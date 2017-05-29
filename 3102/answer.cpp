#include <iostream>
#include <list>
using namespace std;

#define SKIP_NUM 2 + 1
#define INPUT_SUP 100

void solve() {
    // SKIP_NUM個前までの入力，最大値を保存するリスト
    list<int> inputs, each_combo;
    for(int i = 0; i < SKIP_NUM; i++) {
        inputs.push_back(INPUT_SUP);
        each_combo.push_back(0);
    }
    
    int n;
    cin >> n;
    
    int current_input, current_combo, combo_max = 0;
    for(int i = 0; i < n; i++) {
        cin >> current_input;
        current_combo = 1;
        
        std::list<int>::iterator inputs_itr = inputs.begin();
        std::list<int>::iterator each_combo_itr = each_combo.begin();
        for(int j = 0; j < SKIP_NUM; j++) {
            if(*inputs_itr < current_input && current_combo <= *each_combo_itr) {
                current_combo = (*each_combo_itr) + 1;
            }
            inputs_itr++;
            each_combo_itr++;
        }
        
        combo_max = max(combo_max, current_combo);
        
        each_combo.pop_front();
        each_combo.push_back(current_combo);
        inputs.pop_front();
        inputs.push_back(current_input);
    }
    cout << combo_max;
}

int main(void){
    solve();
    return 0;
}
