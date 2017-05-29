<?php
    const SKIP_NUM = 3;
    const INPUT_SUP = 100;
    
    $n = trim(fgets(STDIN));
    
    $inputs = array(); // 入力されるランダムな整数列を格納
    $each_combo = array(); // SKIP_NUM前までのコンボ数を格納
    
    for($i = 0; $i < SKIP_NUM; $i++) {
        array_push($inputs, INPUT_SUP);
        array_push($each_combo, 0);
    }
    $inputs = array_merge($inputs, explode(" ", trim(fgets(STDIN))));
    
    $combo_max = 0;
    for($i = 0; $i < $n; $i++) {
        $current_combo = 1;
        $input = $inputs[$i + SKIP_NUM];
        
        for($skip = 0; $skip < SKIP_NUM; $skip++) {
            if($inputs[$i + $skip] < $input && $current_combo <= $each_combo[$skip]) {
                $current_combo = $each_combo[$skip] + 1;
            }
        }
        
        $combo_max = max($combo_max, $current_combo);
        
        array_push($each_combo, $current_combo);
        array_shift($each_combo);
    }
    
    print($combo_max);
