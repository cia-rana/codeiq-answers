#include <iostream>
#include <math.h>
using namespace std;

struct Answers {
    int ary[12];
    constexpr Answers() : ary() {
        for(int i = 0; i < 12; i++) {
            long long d = pow(10, i);
            long long pi = 314'159'265'358 / ((long long)pow(10, 11 - i));
            for(int j = 1;; j++) {
                if((pi * j / d + 1) * d / j == pi) {
                    ary[i] = j;
                    break;
                }
            }
        }
    }
};

int main() {
    int n;
    cin >> n;
    cout << Answers().ary[n];
}