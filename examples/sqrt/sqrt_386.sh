// The Go compiler will look for files ending in `_GOOS` or `_GOARCH` or `_GOOS_GOARCH` to 
// consider which assembly file to compile. [See go/build](https://golang.org/pkg/go/build/).

∕∕ sqrt_386.s

#include "textflag.h"

TEXT ·Sqrt(SB),NOSPLIT,$0
	FMOVD   x+0(FP),F0
	FSQRT
	FMOVDP  F0,ret+8(FP)
	RET
