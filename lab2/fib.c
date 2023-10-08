#include<stdio.h>
int a=0;
int b=1;

int main(){
    int i = 1,n=4,t;
    while (i < n)
    {
        t = b;
        b = a + b;
        a = t;
        i = i + 1;
    }
    printf("%d",b);
    return 0;
}