	.arch armv7-a
	.global	a
	.bss
	.align	2
a:
	.word	0
	.global	b
	.data
	.align	2
b:
	.word	1
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%d\000"  @printf的字符串参数
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:

	push	{r7, lr}
	sub	sp, sp, #16
	add	r7, sp, #0
	movs	r3, #1
	str	r3, [r7, #4]@局部变量i
	movs	r3, #4
	str	r3, [r7, #8]@局部变量n
	b	.L2
.L3:
	ldr	r3, .L5
.LPIC0:
	add	r3, pc
	ldr	r3, [r3]     @获得b的地址
	str	r3, [r7, #12]@局部变量t
	ldr	r3, .L5+4
.LPIC1:
	add	r3, pc    @获得a的地址
	ldr	r2, [r3]  @访问a
	ldr	r3, .L5+8
.LPIC2:
	add	r3, pc  
	ldr	r3, [r3] @访问b
	add	r2, r2, r3
	ldr	r3, .L5+12
.LPIC3:
	add	r3, pc
	str	r2, [r3] @更新b
	ldr	r3, .L5+16
.LPIC4:
	add	r3, pc
	ldr	r2, [r7, #12] 
	str	r2, [r3] @更新a
	ldr	r3, [r7, #4]  @访问i
	adds	r3, r3, #1
	str	r3, [r7, #4]  @更新i
.L2:
	ldr	r2, [r7, #4]
	ldr	r3, [r7, #8]
	cmp	r2, r3
	blt	.L3 @while循环
	ldr	r3, .L5+20
.LPIC5:
	add	r3, pc
	ldr	r3, [r3] @读取b
	mov	r1, r3
	ldr	r3, .L5+24
.LPIC6:
	add	r3, pc
	mov	r0, r3 @获得字符串地址
	bl	printf(PLT)  @用r0，r1作为参数打印出第i个字符串
	movs	r3, #0
	mov	r0, r3
	adds	r7, r7, #16
	mov	sp, r7  @恢复栈帧
	@ sp needed
	pop	{r7, pc}
.L6:
	.align	2
.L5:
	.word	b-(.LPIC0+4)
	.word	a-(.LPIC1+4)
	.word	b-(.LPIC2+4)
	.word	b-(.LPIC3+4)
	.word	a-(.LPIC4+4)
	.word	b-(.LPIC5+4)
	.word	.LC0-(.LPIC6+4)
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",%progbits
