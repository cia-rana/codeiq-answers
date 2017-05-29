// 幅制約付き最長増加部分列問題(Range-Constrained Longest Increasing Subsequence)として解く．
// n: 入力数，m: スキップ数としたとき，
// 時間計算量O(nlong(m))，空間計算量O(n)のアルゴリズムが存在するが，
// 今回のn，mは比較的小さく，事前計算のオーバーへッドが大きいので，
// 今回は時間計算量O(nm)，空間計算量O(m)のアルゴリズムを採用している．

(function() {
    const SKIP_NUM = 3; // 何個前まで見るか
    const NUM_SUP = 100; // 入力値の上限
    
    function solve(n, nums) {
        // SKIP_NUM個前までの入力を格納
        var preNums = new Array(SKIP_NUM);
        
        // SKIP_NUM個前までのコンボを格納
        var eachCombo = new Array(SKIP_NUM);
        
        for (var i = 0; i < SKIP_NUM; i++) {
            preNums[i] = NUM_SUP;
            eachCombo[i] = 0;
        }
        
        // 最大コンボを見つける
        var comboMax = 0;
        nums.forEach(function(currentNum) {
            var currentCombo = 1;
            
            for (var i = 0; i < SKIP_NUM; i++) {
                if (preNums[i] < currentNum && currentCombo <= eachCombo[i]) {
                    currentCombo = eachCombo[i] + 1;
                }
            }
            
            comboMax = Math.max(comboMax, currentCombo);
            
            preNums.push(currentNum);
            preNums.shift();
            eachCombo.push(currentCombo);
            eachCombo.shift();
        });
        
        return comboMax;
    }
    
    function main(args) {
        var n = Number(args[0]);
        var nums = args[1].split(" ").map(Number);
        
        console.log(solve(n, nums));
        
        return;
    }
    
    // あらかじめ標準入力を全て読み込み，main functionを起動
    (function() {
        var lines = [];
        var reader = require("readline").createInterface({
            input: process.stdin,
            output: process.stdout,
            terminal: false
        });
        reader.on("line", function(line) {
            lines.push(line);
        });
        process.stdin.on("end", function() {
            main(lines);
        });
    })();
})();
