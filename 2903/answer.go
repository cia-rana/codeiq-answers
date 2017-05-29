package main
import (
    "fmt"
    "sync"
)

const D = 1000003

func main() {
    var n int
    fmt.Scan(&n)
    
    divChan := make(chan int)
    go func(n int, divChan chan int) {
        wg := new(sync.WaitGroup)
        for i := 1; i <= n; i++ {
            wg.Add(1)
            go func(m int) {
                defer wg.Done()
                for m % 2 == 0 {
                    m /= 2
                    divChan <- 2
                }
                for d := 3; d * d <= m; d += 2 {
                    for m % d == 0 {
                        m /= d
                        divChan <- d
                    }
                }
                if m > 1 {
                    divChan <- m
                }
            }(i)
        }
        wg.Wait()
        close(divChan)
    }(n, divChan)
    divMap := make(map[int]int)
    for d := range divChan {
        divMap[d]++
    }
    
    gsChan := make(chan int)
    go func(divMap map[int]int, gsChan chan int) {
        wg := new(sync.WaitGroup)
        for d, e := range divMap {
            wg.Add(1)
            go func(n, m, d int) {
                defer wg.Done()
                prd := uint64(1)
                pow := uint64(n)
                div := uint64(D * (d - 1))
                for m > 0 {
                    if m & 1 == 1 {
                        prd = prd * pow % div
                    }
                    pow = pow * pow % div
                    m >>= 1
                }
                gsChan <- int((prd - 1) / uint64(d - 1))
            }(d, n * e + 1, d)
        }
        wg.Wait()
        close(gsChan)
    }(divMap, gsChan)
    sum := 1
    for gs := range gsChan {
        sum = int(uint64(sum) * uint64(gs) % D)
    }
    
    fmt.Println(sum)
}