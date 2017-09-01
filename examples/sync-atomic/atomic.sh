#include "textflag.h"

TEXT ·SwapInt32(SB),NOSPLIT,$0-20
	JMP	·SwapUint32(SB)

TEXT ·SwapUint32(SB),NOSPLIT,$0-20
	MOVQ	addr+0(FP), BP
	MOVL	new+8(FP), AX

	// `XCHGL` 并不等价于 [Write-After-Read](https://en.wikipedia.org/wiki/Hazard_(computer_architecture)#Write_after_read_.28WAR.29), 因为在数据交换的时候总线是加锁的。
	XCHGL	AX, 0(BP)
	MOVL	AX, old+16(FP)
	RET
