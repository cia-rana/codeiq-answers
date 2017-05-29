package main
import (
    "fmt"
    "bufio"
    "os"
    "strconv"
)

var primes = []int{2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47}

func solve(m, n int) int {
    sum := 0
    var f func(int, int)
    g := func(i, t int) {
        if i < 0 {
            if t == n {
                sum++
            }
            return
        }
        
        f(i - 1, t + primes[i])
        f(i - 1, t)
        f(i - 1, t - primes[i])
    }
    f = g
    f(seachPrimeIndex(len(primes) - 1, m), 0)
    return sum
}

func seachPrimeIndex(index, m int) int {
    for i := index; i >= 0; i-- {
        if primes[i] <= m {
            return i
        }
    }
    return -1
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

func main(){
    inputs := fetchInputs(2)
    fmt.Println(solve(inputs[0], inputs[1]))
}