#include"sylib.h"
#include"sylib.c"
const float k=3.0;
float a=2.0;
int b[2]={5,8};

int func(int d){
    if(d==b[0]||d==b[1]){
        return 1; 
    }
    return 0;
}

int main(){
    int i,n;
    i=0;
    n=getint();
    while(i<8){
        n=i*a;
        if(func(n)==1){
            break;
        }
        i=i+1;
    }
    putint(i);
    return 0;
    
}
