∕∕ sqrt_mipsx.s

// This file's name doesn't match any `_GOOS.s` pattern. Instead it uses the following comment to warn the compiler that both `mips` and `mipsle` can use this assembly file.
∕∕ +build mips mipsle

#include "textflag.h"

TEXT ·Sqrt(SB),NOSPLIT,$0
	MOVD	x+0(FP), F0
	SQRTD	F0, F0
	MOVD	F0, ret+8(FP)
	RET
