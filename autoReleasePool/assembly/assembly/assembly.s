//
//  assembly.s
//  assembly
//
//  Created by gmy on 2023/6/19.
//  https://blog.csdn.net/boildoctor/article/details/123249133

.text
.global _test,_add


_test:
mov x0,#0x1 ;立即数以#井号开头,0x是16进制
mov x1,x0
;mov x2,x0+0x12 ;不合法mov右边不能运算
;ldr w12, [x1, #0x1]
add x2,x1,x0
sub x3,x2,x1
ret

_add:
add x0,x0,x1;传递进来的参数前8个都放在x0到x7中,超过8个放在栈中,返回值在x0中
ret

