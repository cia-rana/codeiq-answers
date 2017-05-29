package main

import (
    "fmt"
    "strings"
)

type status struct {
    damage float64
    isDown bool
    preType string
    magnification float64
}

func (s *status) update(attack string) {
    magnification := 1.
        
    if s.isDown {
        magnification *= downMagnification
    }else{
        s.isDown = attackList[attack].isDown
    }
    if s.preType == attack {
        magnification *= sameTypeMagnification
    }
    
    s.preType = attack
    s.magnification = magnification
}

type attackAttribute struct {
    damage float64
    isDown bool
}

var attackList = map[string]attackAttribute{
    "a": attackAttribute{10., false},
    "b": attackAttribute{20., true},
    "c": attackAttribute{20., false},
    "d": attackAttribute{30., false},
}

const (
    downMagnification = .8
    sameTypeMagnification = .5
)

func Start(attackSeq []string) int {
    stat := status{0., false, "", 1.}
    
    for _, attack := range attackSeq {
        stat.update(attack)
        stat.damage += attackList[attack].damage * stat.magnification
    }
    
    return int(stat.damage)
}

func fetchInputs() []string {
    var s string
    fmt.Scan(&s)
    return strings.Split(s, ",")
}

func main() {
    fmt.Print(Start(fetchInputs()))
}