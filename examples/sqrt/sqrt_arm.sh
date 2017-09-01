∕∕ sqrt_arm.s

#include "textflag.h"

TEXT ·Sqrt(SB),NOSPLIT,$0
	MOVD   x+0(FP),F0
	SQRTD  F0,F0
	MOVD  F0,ret+8(FP)
	RET
