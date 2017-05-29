package main
import (
	"fmt"
	"strconv"
	"strings"
)

func flipVertical(x uint64) uint64 {
	k1 := uint64(0x00ff00ff00ff00ff)
	k2 := uint64(0x0000ffff0000ffff)
	x = ((x>>8)&k1)|((x&k1)<<8)
	x = ((x>>16)&k2)|((x&k2)<<16)
	x = (x>>32)|(x<<32)
	return x
}

func flipDiagA1H8(x uint64) uint64 {
	t := 0x0f0f0f0f00000000&(x^(x<<28))
	x ^= t^(t>>28)
	t = 0x3333000033330000&(x^(x<<14))
	x ^= t^(t>>14)
	t = 0x5500550055005500&(x^(x<<7))
	x ^= t^(t>>7)
	return x
}

func rotate90clockwise(x uint64) uint64 {
	return flipVertical(flipDiagA1H8(x))
}

func popcount(x uint64) uint64 {
	x = (x&0x5555555555555555)+((x&0xaaaaaaaaaaaaaaaa)>>1)
	x = (x&0x3333333333333333)+((x&0xcccccccccccccccc)>>2)
	x = (x&0x0f0f0f0f0f0f0f0f)+((x&0xf0f0f0f0f0f0f0f0)>>4)
	x *= 0x0101010101010101
	x = (x>>56)&0xff
	return x
}

func solve(input string) string {
	x, _ := strconv.ParseUint(input, 16, 64)
	result := make([]string, 4)
	for i := 0; i < 4; i++ {
		x = rotate90clockwise(x)
		result[i] = strconv.FormatUint(popcount((x>>8)&^x), 10)
	}
	result = []string{result[1], result[3], result[0], result[2]}
	return strings.Join(result, ",")
}

func main() {
	var input string
	fmt.Scan(&input)
	fmt.Println(solve(input))
}