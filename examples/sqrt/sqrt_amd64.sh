∕∕ sqrt_amd64.s

#include "textflag.h"

TEXT ·Sqrt(SB), NOSPLIT, $0
	XORPS  X0, X0 // break dependency
	SQRTSD x+0(FP), X0
	MOVSD  X0, ret+8(FP)
	RET
