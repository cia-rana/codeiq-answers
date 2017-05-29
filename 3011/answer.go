package main
import (
	"fmt"
	"math"
)

const MAX_N = 10000

type PrimeDeterminedNum struct {
	Value int
	IsPrime bool
}

func isPrime(n int) bool {
	if n < 2{
		return false
	} else if n == 2 {
		return true
	} else if n % 2 == 0 {
		return false
	}
	
	maxNum := int(math.Ceil(math.Sqrt(float64(n))))
	for i := 3; i <= maxNum; i += 2 {
		if n % i == 0 {
			return false
		}
	}
	return true
}

func main(){
	nums := make([]int, 0)
	for {
		n := 0
		fmt.Scan(&n)
		if n == 0 {
			break
		}
		nums = append(nums, n)
	}
	primeDeterminedNums := make([]PrimeDeterminedNum, 0)
	for i := 0; i <= MAX_N; i++ {
		primeDeterminedNums = append(primeDeterminedNums, PrimeDeterminedNum{i, isPrime(i)})
	}
	
	for _, n := range nums {
		indices := make([]int, 0)
		for i, primeDeterminedNum := range primeDeterminedNums {
			if primeDeterminedNum.IsPrime && i >= n {
				indices = append(indices, i - n)
			}
		}
		for i := len(indices) - 1; i >= 0; i-- {
			primeDeterminedNums = append(primeDeterminedNums[:indices[i]], primeDeterminedNums[indices[i]+1:]...)
		}
	}
	
	fmt.Print(primeDeterminedNums[0].Value)
	for _, primeDeterminedNum := range primeDeterminedNums[1:10] {
		fmt.Print(",")
		fmt.Print(primeDeterminedNum.Value)
	}
}