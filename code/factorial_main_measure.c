#include <stdio.h>
#include<sys/time.h>

int main() {
    int i, n, f,k;
    scanf("%d", &n);
    k=1;
    struct timeval start,end;
    gettimeofday(&start, NULL);
    while(k<1000000){
        i = 2;
        f = 1;
        while (i <= n) {
            f = f * i;
            i = i + 1;
        }
    k++;
    }
    gettimeofday(&end, NULL);

    long timeuse = 1000000*(end.tv_sec - start.tv_sec) + end.tv_usec-start.tv_usec;

    printf("time =%ld 微秒\n", timeuse);
    printf("%d\n", f);
    return 0;
}