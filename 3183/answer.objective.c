#include <stdio.h>
int main(){
    // しょきか
    int pos = 0, dir[5] = {-1, 0, 1, 9, -9};
    char field[99] = "Yxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
    
    // あしあとつける
    char c;
    while(scanf(" %c", &c) == 1){
        field[pos+=dir[c % 5]] = 'Y';
    }
    
    // あしあとびょうがする
    size_t i;
    for(i = 0; i < 81; i++){
        printf("%c", field[i]);
        if(i % 9 == 8){
            printf("\n");
        }
    }
    
    // おわり
    return 0;
}
