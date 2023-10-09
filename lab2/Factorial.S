.arch armv7-a  @ ARMv7-A架构

@ 用于保存未初始化的全局变量的comm部分
.comm n, 4 @ 全局变量n, 占用4字节

@ 保存常量的rodata部分
.section .rodata
.align 2
_str0:  @ 字符串_str0定义
        .ascii "%d\0" @ 以"%d\0"作为字符串值, \0代表null字符
.align 2
_str1:  @ 字符串_str1定义
        .ascii "The factorial of %d is %d\n"  @ 以"The factorial of %d is %d\n"作为字符串值

@ 代码段
.section .text
.align 2
.global factorial
factorial:
        str fp, [sp, #-4]!  @ 保存栈帧指针, 同时将栈指针下移
        mov fp, sp  @ 设置栈帧指针
        sub sp, sp, #12  @ 分配12字节的局部变量空间

        mov r0, #2  @ 将2赋值给r0
        str r0, [fp, #-8]  @ 将r0存储到[fp, #-8]中
        mov r0, #1  @ 将1赋值给r0
        str r0, [fp, #-12]  @ 将r0存储到[fp, #-12]中
        
.L1:
        ldr     r0, [fp, #-8]  @ 加载[fp, #-8]到r0
        ldr     r1, _bridge  @ 加载_bridge到r1
        ldr     r1, [r1]  @ 加载[r1]到r1
        cmp     r0, r1  @ 比较r0和r1
        bgt     .L3  @ 如果r0 > r1, 则跳转到.L3

.L2:
        ldr     r0, [fp, #-12]  @ 加载[fp, #-12]到r0
        ldr     r1, [fp, #-8]  @ 加载[fp, #-8]到r1
        mul     r2, r0, r1  @ 计算r0 * r1, 并存储到r2
        str     r2, [fp, #-12]  @ 将r2存储到[fp, #-12]
        ldr     r0, [fp, #-8]  @ 加载[fp, #-8]到r0
        add     r0, r0, #1  @ r0加1， 并存储在r0
        str     r0, [fp, #-8]  @ 将r0存储到[fp, #-8]
        b       .L1  @ 跳转到.L1

.L3:
        ldr     r0, [fp, #-12]  @ 加载[fp, #-12]到r0
        add sp, fp, #0  @ 恢复栈指针
        ldr fp, [sp], #4  @ 恢复栈帧指针
        bx lr  @ 返回

.global main
main:
        push {fp, lr}  @ 保存栈帧指针和返回地址
        add fp, sp, #4  @ 设置栈帧指针
        ldr r1, _bridge  @ 加载_bridge到r1
        ldr r0, _bridge + 4  @ 加载_bridge+4到r0
        bl __isoc99_scanf  @ 调用scanf函数
        bl factorial  @ 调用factorial函数
        mov r2, r0  @ 将r0的值复制给r2
        ldr r1, _bridge  @ 加载_bridge到r1
        ldr r1, [r1]  @ 加载[r1]到r1
        ldr r0, _bridge + 8  @ 加载_bridge+8到r0
        bl printf  @ 调用printf函数
        mov r0, #0  @ 将0赋值给r0
        pop {fp, pc}  @ 弹出栈帧指针和返回地址

_bridge:
.word n  @ _bridge的值为n的地址
.word _str0  @ _bridge+4的值为字符串_str0的地址
.word _str1  @ _bridge+8的值为字符串_str1的地址

.section .note.GNU-stack,"",%progbits @ 用于防止攻击者通过注入可执行代码到程序堆栈来攻击程序。