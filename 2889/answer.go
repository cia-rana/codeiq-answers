package main
import (
    "fmt"
    "math"
    "math/big"
)

func isArithmetic(a []uint64) bool {
    s := len(a)
    if s < 3 {
        return false
    }
    
    base := a[1] - a[0]
    for i := 2; i < s; i++ {
        if base != a[i] - a[i-1] {
            return false
        }
    }
    return true
}

func isGeometric(a []uint64) bool {
    s := len(a)
    if s < 3 {
        return false
    }
    
    for i := 2; i < s; i++ {
    	a_1_l := a[i] & 0xffffffff
    	a_1_m := a[i] >> 32
    	a_2_l := a[i-1] & 0xffffffff
    	a_2_m := a[i-1] >> 32
    	a_3_l := a[i-2] & 0xffffffff
    	a_3_m := a[i-2] >> 32
    	
    	b_l := a_1_l * a_3_l
    	c_l := a_2_l * a_2_l
    	b_m_1 := a_1_l * a_3_m
    	b_m_2 := a_3_l * a_1_m
    	c_m_1 := a_2_l * a_2_m
    	b_m := b_m_1 + b_m_2
    	c_m := c_m_1 * 2
    	b_u := a_1_m * a_3_m + carry(b_m_1, b_m_2)
    	c_u := a_2_m * a_2_m + carry(c_m_1, c_m_1)
    	
    	if b_l & 0xffffffff != c_l & 0xffffffff {
    		return false
    	}
    	if (b_l >> 32) + (b_m & 0xffffffff) != c_l >> 32 + (c_m & 0xffffffff) {
    		return false
    	}
    	if (b_m >> 32) + (b_u & 0xffffffff) != c_m >> 32 + (c_u & 0xffffffff) {
    		return false
    	}
    	if b_u >> 32 != c_u >> 32 {
    		return false
    	}
    }
    return true
}

func carry(a, b uint64) uint64 {
	if math.MaxUint64 - a < b {
		return 0
	}
	return 1
}

func isFibonacci(a []uint64) bool {
    s := len(a)
    if s < 3 || !isPerfectSquareForFibonacci(a[0]){
        return false
    }
    
    for i := 2; i < s; i++ {
        if a[i] != a[i-1] + a[i-2] {
            return false
        }
    }
    return true
}

// Let N is natural number.
// N is the number of Fibonacci if 5 * N^2 + 4 or 5 * N^2 - 4 is perfect square,
// otherwise not.
// By http://math.stackexchange.com/questions/1100943/why-does-this-test-for-fibonacci-work
// 1 - (44/256) * (1/2)^11 = 0.999916...
func isPerfectSquareForFibonacci(n uint64) bool {
    for k, v := range map[int][]int{
        256: []int{0, 1, 4, 9, 16, 17, 25, 33, 36, 41, 49, 57, 64, 65, 68, 73, 81, 89, 97, 100, 105, 113, 121, 129, 132, 137, 144, 145, 153, 161, 164, 169, 177, 185, 193, 196, 201, 209, 217, 225, 228, 233, 241, 249},
          3: []int{0, 1},
          5: []int{0, 1, 4},
          7: []int{0, 1, 2, 4},
         11: []int{0, 1, 3, 4, 5, 9},
         13: []int{0, 1, 3, 4, 9, 10, 12},
         17: []int{0, 1, 2, 4, 8, 9, 13, 15, 16},
         19: []int{0, 1, 4, 5, 6, 7, 9, 11, 16, 17},
         23: []int{0, 1, 2, 3, 4, 6, 8, 9, 12, 13, 16, 18},
         29: []int{0, 1, 4, 5, 6, 7, 9, 13, 16, 20, 22, 23, 24, 25, 28},
         31: []int{0, 1, 2, 4, 5, 7, 8, 9, 10, 14, 16, 18, 19, 20, 25, 28},
         37: []int{0, 1, 3, 4, 7, 9, 10, 11, 12, 16, 21, 25, 26, 27, 28, 30, 33, 34, 36},
    }{
        r := int(n % uint64(k))
        for _, s := range []int{-1, 1} {
            r = (5 * r * r + s * 4) % k
            for _, m := range v {
                if m == r {
                    return true
                }
            }
        }
    }
    
    if n < uint64((1<<31) - (1<<28)) {
        floorSqrtN := uint64(math.Sqrt(float64(5 * n * n + 4)))
        if floorSqrtN * floorSqrtN == n {
            return true
        }
        floorSqrtN = uint64(math.Sqrt(float64(5 * n * n - 4)))
        return floorSqrtN * floorSqrtN == n
    } else {
        prec := uint(200)
        bigN := new(big.Float).SetPrec(prec).SetUint64(n)
        big4 := new(big.Float).SetPrec(prec).SetUint64(uint64(4))
        big5 := new(big.Float).SetPrec(prec).SetUint64(uint64(5))
        tmp := new(big.Float).Mul(new(big.Float).Mul(bigN, bigN), big5)
        floorSqrtN, _ := sqrt(new(big.Float).Add(tmp, big4), prec).Uint64()
        if floorSqrtN * floorSqrtN == n {
            return true
        }
        floorSqrtN, _ = sqrt(new(big.Float).Sub(tmp, big4), prec).Uint64()
        return floorSqrtN * floorSqrtN == n
        
        return false
    }
}

func sqrt(n *big.Float, prec uint) *big.Float {
	steps := int(math.Log2(float64(prec)))

	half := new(big.Float).SetPrec(prec).SetFloat64(0.5)

	x := new(big.Float).SetPrec(prec).SetInt64(1)
	t := new(big.Float)

	for i := 0; i <= steps; i++ {
		t.Quo(n, x)  // t = n / x_n
		t.Add(x, t)    // t = x_n + (2.0 / x_n)
		x.Mul(half, t) // x_{n+1} = 0.5 * t
	}
	return x
}

func fetchInputs() []uint64 {
    outputs := make([]uint64, 0)
    for {
        var n uint64
        fmt.Scan(&n)
        if n == 0 {
            break
        }
        outputs = append(outputs, n)
    }
    return outputs
}

func main() {
    inputs := fetchInputs()
    switch {
        case isArithmetic(inputs):
            fmt.Println("A")
        case isGeometric(inputs):
            fmt.Println("G")
        case isFibonacci(inputs):
            fmt.Println("F")
        default:
            fmt.Println("x")
    }
}