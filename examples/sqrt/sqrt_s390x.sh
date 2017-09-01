∕∕ sqart_s389x.s

#include "textflag.h"

TEXT ·Sqrt(SB),NOSPLIT,$0
	FMOVD x+0(FP), F1
	FSQRT F1, F1
	FMOVD F1, ret+8(FP)
	RET
