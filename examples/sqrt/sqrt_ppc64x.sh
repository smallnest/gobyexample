∕∕ sqrt_ppc64x.s

∕∕ +build ppc64 ppc64le
#include "textflag.h"

TEXT ·Sqrt(SB),NOSPLIT,$0
	FMOVD	x+0(FP), F0
	FSQRT	F0, F0
	FMOVD	F0, ret+8(FP)
	RET
