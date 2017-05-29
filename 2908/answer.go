package main
import (
    "fmt"
    "bufio"
    "os"
    "strconv"
)

// x_1 + x_2 + ... + x_m = n, x1 <= x2 <= ... <= x_m を満たす
// 組(x_1, x_2, ..., x_m)の個数
func f(m, n, i int) int {
    if(m <= 1) {
        return 1
    }
    
    sum := 0
    for j := i; 2 * j <= n; j++ {
        sum += f(m - 1, n - j, j)
    }
    return sum
}

func solve(m, n int) int {
    sum := 0
    for i := 1; i * m <= n; i++ {
        if(n % i != 0) {
            continue
        }
        sum += f(m - 1, n / i - 1, 1)
    }
    return sum
}

func fetchInputs(size int) []int {
    sc := bufio.NewScanner(os.Stdin)
    outputs := make([]int, size)
    sc.Split(bufio.ScanWords)
    
    for i := 0; i < size; i++ {
        sc.Scan()
        n, e := strconv.Atoi(sc.Text())
        if e != nil {
            panic(e)
        }
        outputs[i] = n
    }
    return outputs
}

func main() {
    inputs := fetchInputs(2)
    fmt.Print(solve(inputs[0], inputs[1]))
}