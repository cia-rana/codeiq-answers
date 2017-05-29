// 幅制約付き最長増加部分列問題(Range-Constrained Longest Increasing Subsequence)として解く．
// n: 入力数，m: スキップ数としたとき，
// 時間計算量O(nlong(m))，空間計算量O(n)のアルゴリズムが存在するが，
// 今回のn，mは比較的小さく，事前計算のオーバーへッドが大きいので，
// 今回は時間計算量O(nm)，空間計算量O(m)のアルゴリズムを採用している．

import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.util.List;
import java.util.LinkedList;
import java.util.stream.Stream;
import java.util.stream.Collectors;
import java.util.Iterator;
import java.lang.Math;

class Solver {
    private static final int SKIP_NUM = 3; // 何個前まで見るか
    private static final int INPUT_SUP = 100; // 入力値の上限
    
    public void solve() throws Exception {
        try(BufferedReader br = new BufferedReader(new InputStreamReader(System.in))) {
            // 入力数は使わないので破棄
            br.readLine();
            
            // SKIP_NUM個前までの入力を格納
            List<Integer> inputs = Stream.generate(() -> INPUT_SUP)
                                     .limit(SKIP_NUM)
                                     .collect(Collectors.toCollection(LinkedList::new));
            
            // SKIP_NUM個前までの最大コンボを格納
            List<Integer> eachMax = Stream.generate(() -> 0)
                                      .limit(SKIP_NUM)
                                      .collect(Collectors.toCollection(LinkedList::new));
            
            // 最大コンボを見つける
            int comboMax = 0;
            for (int currentInput : Stream.of(br.readLine().split(" "))
                                      .mapToInt(Integer::parseInt)
                                      .toArray()) {
                int currentCombo = 1;
                
                Iterator<Integer> inputsItr = inputs.iterator();
                Iterator<Integer> eachMaxItr = eachMax.iterator();
                for (int i = 0; i < SKIP_NUM; i++) {
                    int input = inputsItr.next();
                    int max = eachMaxItr.next();
                    if (input < currentInput && currentCombo <= max) {
                        currentCombo = max + 1;
                    }
                }
                
                comboMax = Math.max(comboMax, currentCombo);
                
                inputs.add(currentInput);
                inputs.remove(0);
                eachMax.add(currentCombo);
                eachMax.remove(0);
            }
            
            System.out.println(comboMax);
        }
    }
}

public class Main {
    public static void main(String[] args) throws Exception {
        Solver solver = new Solver();
        solver.solve();
    }
}
