package main
import (
	"fmt"
	"strconv"
	"strings"
	"C"
)

func popcount(x uint64) int {
	return int(C.__builtin_popcountll(C.ulonglong(x)))
}

func convertPopcountString(x uint64) string {
	return strconv.Itoa(popcount(x))
}

func solve(input string) string {
	x, _ := strconv.ParseUint(input, 16, 64)
	result := make([]string, 4)
	result[0] = convertPopcountString((x<<8)&^x)
	result[1] = convertPopcountString((x>>8)&^x)
	result[2] = convertPopcountString((x<<1)&^x&0xfefefefefefefefe)
	result[3] = convertPopcountString((x>>1)&^x&0x7f7f7f7f7f7f7f7f)
	return strings.Join(result, ",")
}

func main() {
	var input string
	fmt.Scan(&input)
	fmt.Println(solve(input))
}