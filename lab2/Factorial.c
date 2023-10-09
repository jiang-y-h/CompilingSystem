#include <stdio.h>
int n;

int factorial(){
    int i = 2, f = 1;
    while (i <= n) {
        f = f * i;
        i = i + 1;
    }
    return f;
}

int main(){
    scanf("%d", &n);
    printf("The factorial of %d is %d\n", n, factorial());
    return 0;
}