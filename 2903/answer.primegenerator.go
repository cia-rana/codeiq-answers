package main
import (
    "fmt"
    "sync"
)

const D = 1000003

func GeneratePrime(out chan <- int) {
    ch1 := make(chan int)
    go func(ch chan <- int) {
        ch <- 2
        for i := 3; ; i += 2 {
            ch <- i
        }
    }(ch1)
    
    for {
        prime := <- ch1
        if prime > 1100 {
            return
        }
        out <- prime
        ch2 := make(chan int)
        go func(in <- chan int, out chan <- int, prime int) {
            for {
                primeCandidate := <- in
                if primeCandidate % prime != 0 {
                    out <- primeCandidate
                }
            }
        }(ch1, ch2, prime)
        ch1 = ch2
    }
}

func main() {
    var n int
    fmt.Scan(&n)
    
    primeChan := make(chan int)
    go GeneratePrime(primeChan)
    
    gsChan := make(chan int)
    go func() {
        wg := new(sync.WaitGroup)
        for prime := range primeChan {
            if prime > n {
                break
            }
            
            wg.Add(1)
            go func(prime int, out chan <- int) {
                defer wg.Done()
                
                sum := 0
                {
                    m := n
                    for m > 0 {
                        m /= prime
                        sum += m
                    }
                }
                {
                    prd := uint64(1)
                    pow := uint64(prime)
                    div := uint64(D * (prime - 1))
                    m := n * sum + 1
                    for m > 0 {
                        if m & 1 == 1 {
                            prd = prd * pow % div
                        }
                        pow = pow * pow % div
                        m >>= 1
                    }
                    out <- int((prd - 1) / uint64(prime - 1))
                }
            }(prime, gsChan)
        }
        wg.Wait()
        close(gsChan)
    }()
    
    sum := 1
    for gs := range gsChan {
        sum = int(uint64(sum) * uint64(gs) % D)
    }
    
    fmt.Println(sum)
}