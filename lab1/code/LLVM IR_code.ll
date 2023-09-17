;全局常量声明 const float k=2.0;
@k = constant float 3.000000e+00, align 4
;全局变量声明 float a=2.0;
@a = global float 3.000000e+00, align 4
;全局变量声明 b [2]={5 ,8};
@b = global [2 x i32 ] [ i32 5 , i32 8 ] , align 4

; 定义函数 float func (int d)
define float @func (i32 %0){
    %2 = alloca i32 , align 4 ;为传入的参数分配地址
    store i32 %0, i32 ∗ %2, align 4;传参
    
    %b_0 = getelementptr inbounds [2 x i32], [2 x i32]* @b, i32 0, i32 0 ; 获取全局变量b的第一个元素
    %b_1 = getelementptr inbounds [2 x i32], [2 x i32]* @b, i32 0, i32 1 ; 获取全局变量b的第二个元素


    ;实现if(d==b[0]||d==b[1])
    %cmp1 = icmp eq i32 %2, %b_0
    %cmp2 = icmp eq i32 %2, %b_1
    %or = or i1 %cmp1, %cmp2
    %result = select i1 %or, i32 1, i32 0
    ret i32 %result
    }


define i32 @main(){
    %i=alloca i32 , align 4 ;
    %n=alloca i32 , align 4 ;
    store i32 0 , i32 ∗ %i, align 4;%i=0
    %1 = call i32 @getint ();
    store i32 %1, i32 ∗ %n, align 4 ;n=getint()
    br %5

5:
    ;执行while循环
    %3 = load i32 , i32 ∗ %i, align 4 ; 局 部 变 量 i=%6=0
    %4 = icmp slt i32 %3, 8
    ; 如果 i <8，则跳转则label%6，否则跳转至lable%7
    br i1 %4, label %6, label %7

6:
    %8 = load i32, i32 ∗ @a, align 4 ;
    %9 = sitofp i32 %4 to float;将i从int转换为float
    %10 = fmul float %8, %9;
    %11 = fptosi float %10 to i32;将float转换为int
    %12 = call i32 @func (i32 %11) 
    br i1 %12, label %7, label %8

8:
    %13 = load i32 , i32 ∗ %i, align 4
    %14 = add nsw i32 %13, 1
    store i32 %14, i32 ∗ %i, align 4 ; 实 现 i=i+1， 值 存 入%2
    br label %5

7:
    call void @putint (i32 %i) ; 调用函数 putint
    ret i32 0


    
}

declare i32 @getint ()
declare void @putint ( i32 )
