#include <stdio.h>

int main() {
    int i, n,f;
    scanf("%d", &n);
    i = 2;
    f=1;
    while ((i+1)<= n) {
        f = f * i*(i+1);
        i = i + 2;
    }
    if(n%2==0){
        f=f*n;
    }
    printf("%d\n", f);
    return 0;
}