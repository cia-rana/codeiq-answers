package main
import (
    "fmt"
    "strings"
)

const sideLength = 4

type Queue []*Node

func (q *Queue) isEmpty() bool {
    return len(*q) == 0
}

func (q *Queue) enqueue(node *Node) {
    *q = append(*q, node)
}

func (q *Queue) dequeue() *Node {
    if q.isEmpty() {
        return nil
    }
    n := (*q)[0]
    *q = (*q)[1:]
    return n
}

type Graph struct {
    maxCost int
    nodes []*Node
}

type Node struct {
    cost int
    inCount int
    neighborNodes []*Node
}

func makeGraph(rows []string) Graph {
    hexHeight := sideLength * 2 - 1
    
    // 六角形に整列されたノード（hexNode）を生成する
    hexNodes := make([][]Node, hexHeight)
    for i, row := range rows {
        hexNodes[i] = make([]Node, 0)
        for j := 0; j < len(row); j++ {
            hexNodes[i] = append(hexNodes[i], Node{cost: 1, inCount: 0, neighborNodes: make([]*Node, 0)})
        }
    }
    
    // ノード間を繋ぎ，有向グラフを構築する
    graph := Graph{maxCost: 0, nodes: make([]*Node, 0)}
    for i, row := range rows {
        delta_up := (hexHeight - i) / sideLength
        delta_down := (i + 1) / sideLength
        for j, c := range row {
            for _, p := range [][]int{{i-1, j-delta_up}, {i-1, j+1-delta_up}, {i, j-1}, {i, j+1}, {i+1, j-delta_down}, {i+1, j+1-delta_down}} {
                if 0 <= p[0] && p[0] < hexHeight && 0 <= p[1] && p[1] < len(rows[p[0]]){
                    if uint8(c) < rows[p[0]][p[1]] {
                        // 隣接ノードを加える
                        hexNodes[i][j].neighborNodes = append(hexNodes[i][j].neighborNodes, &hexNodes[p[0]][p[1]])
                    } else if uint8(c) > rows[p[0]][p[1]] {
                        // 入次数をカウントする
                        hexNodes[i][j].inCount++
                    }
                }
            }
            // hexNodeを有効グラフのノードとして加える
            graph.nodes = append(graph.nodes, &hexNodes[i][j])
        }
    }
    
    return graph
}

func solve() int {
    var s string
    fmt.Scan(&s)
    rows := strings.Split(s, "/")
    
    graph := makeGraph(rows)
    
    // 入次数0のノードを集めるキュー
    zeroQueue := new(Queue)
    for _, node := range graph.nodes {
        if node.inCount == 0{
            zeroQueue.enqueue(node)
        }
    }
    
    for node := zeroQueue.dequeue(); node != nil; node = zeroQueue.dequeue() {
        for _, neighborNode := range (*node).neighborNodes {
            if (*neighborNode).cost < (*node).cost + 1 {
                (*neighborNode).cost = (*node).cost + 1
                if graph.maxCost < (*neighborNode).cost {
                    graph.maxCost = (*neighborNode).cost
                }
            }
            
            (*neighborNode).inCount--
            
            if (*neighborNode).inCount == 0 {
                zeroQueue.enqueue(neighborNode)
            }
        }
    }
    
    return graph.maxCost
}

func main(){
    fmt.Print(solve())
}