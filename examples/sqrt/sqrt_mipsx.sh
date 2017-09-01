∕∕ sqrt_mipsx.s

// 这个文件名并不包含 `_GOOS.s` 模式，相反它使用下面的注释告诉编译器`mips` 和`mipsle`两种架构都可以使用这个汇编文件。
∕∕ +build mips mipsle

#include "textflag.h"

TEXT ·Sqrt(SB),NOSPLIT,$0
	MOVD	x+0(FP), F0
	SQRTD	F0, F0
	MOVD	F0, ret+8(FP)
	RET
