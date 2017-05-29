package main

import (
    "fmt"
    "math"
)

// return max value of (n - m) ^ m
// m = 0 ~ n
func maxValue(n int) int {
    max := 0
    for m := n; m >= 0; m-- {
        x := int(math.Pow(float64(n - m), float64(m)))
        if max > x {
            return max
        }
        max = x
    }
    return max
}

func main() {
    var n int
    fmt.Scan(&n)
    fmt.Print(maxValue(n))
}