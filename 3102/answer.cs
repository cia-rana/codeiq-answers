// 幅制約付き最長増加部分列問題(Range-Constrained Longest Increasing Subsequence)として解く．
// n: 入力数，m: スキップ数としたとき，
// 時間計算量O(nlong(m))，空間計算量O(n)のアルゴリズムが存在するが，
// 今回のn，mは比較的小さく，事前計算のオーバーへッドが大きいので，
// 今回は時間計算量O(nm)，空間計算量O(m)のアルゴリズムを採用している．

using System;
using System.Linq;
using System.Collections.Generic;

class Solver
{
    private static readonly int SKIP_NUM = 3; // 何個前まで見るか
    private static readonly int INPUT_SUP = 100; // 入力値の上限
    
    public void solve()
    {
        // 入力数は使わないので破棄
        Console.ReadLine();
        
        var inputs = new List<int>(); // SKIP_NUM個前までの入力を格納
        var eachCombo = new List<int>(); // SKIP_NUM個前までのコンボを格納
        foreach (int _ in Enumerable.Range(0, SKIP_NUM))
        {
            inputs.Add(INPUT_SUP);
            eachCombo.Add(0);
        }
        
        // 最大コンボを見つける
        int comboMax = 0;
        foreach (int currentInput in Console.ReadLine().Split(' ')
                                       .Select(int.Parse).ToArray())
        {
            int currentCombo = 1;
            
            foreach (int skip in Enumerable.Range(0, SKIP_NUM))
            {
                if (inputs[skip] < currentInput && currentCombo <= eachCombo[skip])
                {
                    currentCombo = eachCombo[skip] + 1;
                }
            }
            
            comboMax = Math.Max(comboMax, currentCombo);
            
            inputs.RemoveAt(0);
            inputs.Add(currentInput);
            eachCombo.RemoveAt(0);
            eachCombo.Add(currentCombo);
        }
        
        Console.Write(comboMax);
    }
}

class Program
{
    static void Main(string[] args)
    {
        var solver = new Solver();
        solver.solve();
    }
}
