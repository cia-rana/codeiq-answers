#include <iostream>
#include <list>
using namespace std;

#define SKIP_NUM 2 + 1
#define INPUT_SUP 100

void solve() {
    // SKIP_NUM個前までの入力，最大値を保存するリスト
    list<int> inputs(SKIP_NUM, INPUT_SUP), each_max(SKIP_NUM, 0);
    
    int n;
    cin >> n;
    
    int current_input, current_combo, combo_max = 0;
    for(int i = 0; i < n; i++) {
        cin >> current_input;
        current_combo = 1;
        
        auto inputs_itr = inputs.begin();
        auto each_max_itr = each_max.begin();
        for(int j = 0; j < SKIP_NUM; j++) {
            if(*inputs_itr < current_input && current_combo <= *each_max_itr) {
                current_combo = *each_max_itr + 1;
            }
            inputs_itr++;
            each_max_itr++;
        }
        
        combo_max = max(combo_max, current_combo);
        
        inputs.pop_front();
        inputs.push_back(current_input);
        each_max.pop_front();
        each_max.push_back(current_combo);
    }
    cout << combo_max;
}

int main(void){
    solve();
    return 0;
}
