/*

  M_nはM_{n-1}3つ（それぞれ，M_{n-1, 1}, M_{n-1, 2}, M_{n-1, 3}とする）
  を以下のように組み合わせることで構成できる．
  (1) M_{n-1, 1}の終点とM_{n-1, 2}の始点を繋ぐ．
  (2) M_{n-1, 3}の始点をM_{n-1, 1}の始点から垂直に下した端点と繋ぎ，
      M_{n-1, 3}の終点をM_{n-1, 2}の始点から垂直に下した端点を繋ぐ．
  
  よって，迷路M_nを最短でゴールするたどり方の数F_nは，
  (1)で繋いだ迷路のF_{n-1}^2通りと，(2)で繋いだ迷路の1*F_{n-1}*1=F_{n-1}通り
  の合計F_n = F_{n-1}^2 + F_{n-1} = F_{n-1} * (F_{n-1} + 1)通り（F_1 = 1）となる．
  
  一方，F_nを1000003で割った余りは周期性を利用して求める（周期分のF_nを保存しておく）．
  
  計算量は，F_n % 1000003の周期オーダーになる．

*/

package main
import . "fmt"

const dividend = 1000003

func searchKey(table map[int64]int, value int) int64 {
    for k, v := range table {
        if v == value {
            return k
        }
    }
    return -1
}

func solve(n int) int {
    indexTable := make(map[int64]int) // key: nth term, value: nth
    a := int64(1)
    
    for i := 1; i < n; i++ {
        a *= a + 1
        a %= dividend
        if index, ok := indexTable[a]; ok {
            a = searchKey(indexTable, index + (n - index) % (i - index) - 1)
            break
        }
        indexTable[a] = i
    }
    
    return int(a)
}

func main(){
    var n int
    Scan(&n)
    Print(solve(n))
}