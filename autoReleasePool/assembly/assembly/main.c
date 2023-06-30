//
//  main.c
//  assembly
//
//  Created by gmy on 2023/6/19.
//

#include <stdio.h>
#include "assembly.h"


//int double_num(int num) {
//    return num * 2;
//}

// 内联汇编
int double_num(int num) {
    __asm__ __volatile__(
                 "lsl x0, x0, 1\n"
                 "str x0, [sp, #12]\n"
                 );
    
    return num;
}

//int double_num_times(int num, int times) {
//    while (times--) {
//        num *= 2;
//    }
//    return num;
//}

int double_num_times(int num, int times) {
    int ret;
    __asm__ __volatile__(
                 "lsl x0, x0, x1\n"
                 "mov %0, x0"
                 :"=r"(ret)
                 :
                 :
                 );
    return ret;
}


int main(int argc, const char * argv[]) {
    int res = double_num(5);
    printf("res = %d\n", res);
    int res1 = double_num_times(4, 3);
    printf("res1 = %d\n", res1);
    int res2 = add(3, 5);
    printf("res2 = %d\n", res2);
    test();
    return 0;
}
