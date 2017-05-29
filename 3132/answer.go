package main
import (
	"fmt"
)

type PrimeGenerator struct {
	primeChan chan uint32
}

func NewPrimeGenerator() *PrimeGenerator {
	primeGenerator := PrimeGenerator{
		primeChan: make(chan uint32),
	}
	
	go primeGenerator.start()
	
	return &primeGenerator
}

func (p *PrimeGenerator) start() {
	multiples := map[uint32]uint32{}
	
	p.primeChan <- 2
	for num := uint32(3); ; num += 2 {
		factor, hasFactor := multiples[num]
		if hasFactor {
			delete(multiples, num)
		} else {
			factor = num << 1
		}
		
		for newNum := num + factor; ; newNum += factor {
			_, hasNewFactor := multiples[newNum]
			if !hasNewFactor {
				multiples[newNum] = factor
				break
			}
		}
		
		if !hasFactor {
			p.primeChan <- num
		}
	}
}

func (p *PrimeGenerator) Next() uint32 {
	return <- p.primeChan
}

func main() {
	var input uint32
	fmt.Scan(&input)
	
	primeReceiver := NewPrimeGenerator()
	
	for i := input; i > 1; i-- {
		primeReceiver.Next()
	}
	for i := primeReceiver.Next() - input; i > 1; i-- {
		primeReceiver.Next()
	}
	fmt.Print(primeReceiver.Next())
}
