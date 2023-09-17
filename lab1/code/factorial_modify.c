#include <stdio.h>
#define I 2
#define F 1
int i = I, f = F;

int main() {
     int n;

     if(1==2)
         printf("Dead Code!");

    // 输入一个整数 n
    scanf("%d", &n);

    // 计算阶乘
    while (i <= n) {
        f = f * i++;

     }

    // 输出结果
    printf("%d", f);
    //返回
    return 0;
}