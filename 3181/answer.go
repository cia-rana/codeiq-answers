package main
import (
	"fmt"
)

const D = 1000003

type PrimeGenerator struct {
	next func() uint32
}

func NewPrimeGenerator() *PrimeGenerator {
	primeGenerator := PrimeGenerator{}
	
	multiples := map[uint32]uint32{}
	wheelCycle := []uint32{10, 2, 4, 2, 4, 6, 2, 6, 4, 2, 4, 6, 6, 2, 6, 4, 2, 6, 4, 6, 8, 4, 2, 4, 2, 4, 8, 6, 4, 6, 2, 4, 6, 2, 6, 6, 4, 2, 4, 6, 2, 6, 4, 2, 4, 2, 10, 2}
	wheelCycleIndices := []uint32{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, 0, 3, 0, 4, 0, 0, 0, 5, 0, 0, 0, 0, 0, 6, 0, 7, 0, 0, 0, 0, 0, 8, 0, 0, 0, 9, 0, 10, 0, 0, 0, 11, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 13, 0, 14, 0, 0, 0, 0, 0, 15, 0, 0, 0, 16, 0, 17, 0, 0, 0, 0, 0, 18, 0, 0, 0, 19, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 22, 0, 23, 0, 0, 0, 24, 0, 25, 0, 0, 0, 26, 0, 0, 0, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 28, 0, 0, 0, 29, 0, 0, 0, 0, 0, 30, 0, 31, 0, 0, 0, 32, 0, 0, 0, 0, 0, 33, 0, 34, 0, 0, 0, 0, 0, 35, 0, 0, 0, 0, 0, 36, 0, 0, 0, 37, 0, 38, 0, 0, 0, 39, 0, 0, 0, 0, 0, 40, 0, 41, 0, 0, 0, 0, 0, 42, 0, 0, 0, 43, 0, 44, 0, 0, 0, 45, 0, 46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 47}
	var num uint32
	var i uint32 = 0
	primeGenerator.next = func() uint32 {
		if num == 0 {
			num = 2
			return 2
		}
		if num == 2 {
			num = 3
			return 3
		}
		if num == 3 {
			num = 5
			return 5
		}
		if num == 5 {
			num = 1
			return 7
		}
		
		for ; ; {
			num += wheelCycle[i]
			i = (i + 1) % 48
			
			factor, hasFactor := multiples[num]
			var j uint32
			if hasFactor {
				delete(multiples, num)
				j = wheelCycleIndices[(num / factor) % 210]
			} else {
				factor = num
			}
			
			for newNum := num + factor * wheelCycle[j]; ; newNum += factor * wheelCycle[j] {
				_, hasNewFactor := multiples[newNum]
				if !hasNewFactor {
					multiples[newNum] = factor
					break
				}
				j = (j + 1) % 48
			}
			
			if !hasFactor {
				return num
			}
		}
	}
	
	return &primeGenerator
}

func (p *PrimeGenerator) Next() uint32 {
	return p.next()
}

// return n^m mod d
func powMod(n, m, d uint64) uint64 {
	prd := uint64(1)
	pow := n
	for ; m > 0; m /= 2 {
		if m & 1 == 1 {
			prd = prd * pow % d
		}
		pow = pow * pow % d
	}
	return prd
}

func solve(n uint64) uint64 {
	primeGenerator := NewPrimeGenerator()
	
	prd := uint64(1)
	for ;; {
		p := uint64(primeGenerator.Next())
		if p > n {
			break
		}
		
		var s uint64
		for m := n; m > 0; m /= p {
			s += m / p
		}
		
		// φ(p^s * q^t) = p^{s - 1}(p - 1) * q^{t - 1}(q - 1) (Let p, q be prime numbers with gcd(p, q) = 1)
		prd = prd * powMod(p, s - 1, D) * (p - 1) % D
	}
	
	return prd
}

func main() {
	var n uint64
	fmt.Scan(&n)
	fmt.Println(solve(n))
}
