;全局常量声明 const float k=2.0;
@k = constant float 3.000000e+00, align 4
;全局变量声明 float a=2.0;
@a = global float 3.000000e+00, align 4
;全局变量声明 b [2]={5 ,8};
@b = global [2 x i32 ] [ i32 5 , i32 8 ] , align 4

; 定义函数 bool func (int d)
define i1 @func (i32 %0){
    %2 = alloca i32 , align 4 ;为传入的参数分配地址
    store i32 %0, i32* %2, align 4;传参
    
    %b_0 = getelementptr inbounds [2 x i32], [2 x i32]* @b, i32 0, i32 0 ; 获取全局变量b的第一个元素
    %b_1 = getelementptr inbounds [2 x i32], [2 x i32]* @b, i32 0, i32 1 ; 获取全局变量b的第二个元素
    

    ;实现if(d==b[0]||d==b[1])
    %cmp1 = icmp eq i32* %2, %b_0
    %cmp2 = icmp eq i32* %2, %b_1
    %or = or i1 %cmp1, %cmp2
    %result = select i1 %or, i1 1, i1 0
    ret i1 %result
    }


define i32 @main(){
    %i=alloca i32 , align 4 ;
    %n=alloca i32 , align 4 ;
    store i32 0 , i32* %i, align 4;%i=0
    %1 = call i32 @getint ();
    store i32 %1, i32* %n, align 4 ;n=getint();
    br label %2
2:
    ;执行while循环
    %3 = load i32 , i32* %i, align 4 ; 局 部 变 量
    %4 = icmp slt i32 %3, 8

    br i1 %4, label %5, label %14
5:
    %6 = load float, float * @a, align 4 ;
    %7 = sitofp i32 %3 to float;将i从int转换为float
    %8 = fmul float %6, %7;
    %9 = fptosi float %8 to i32;将float转换为int
    %10 = call i1 @func (i32 %9) 
    br i1 %10, label %14, label %11

11:
    %12 = load i32 , i32 * %i, align 4
    %13 = add nsw i32 %12, 1
    store i32 %13, i32 * %i, align 4 ; 实 现 i=i+1， 值 存 入%2
    br label %2

14:
    %loaded_i = load i32, i32* %i, align 4 ; 从指针 %i 中加载整数值
    call void @putint(i32 %loaded_i) ; 调用函数 putint 传递整数值
    ret i32 0
}

declare i32 @getint ()
declare void @putint ( i32 )
