// Go编译器会查找以 `_GOOS` 或 `_GOARCH` 或 `_GOOS_GOARCH`结尾的文件，以便选择合适的汇编文件来编译，具体可以查看  [See go/build](https://golang.org/pkg/go/build/)。

∕∕ sqrt_386.s

#include "textflag.h"

TEXT ·Sqrt(SB),NOSPLIT,$0
	FMOVD   x+0(FP),F0
	FSQRT
	FMOVDP  F0,ret+8(FP)
	RET
