#include "textflag.h"

TEXT ·SwapInt32(SB),NOSPLIT,$0-20
	JMP	·SwapUint32(SB)

TEXT ·SwapUint32(SB),NOSPLIT,$0-20
	MOVQ	addr+0(FP), BP
	MOVL	new+8(FP), AX

	// The `XCHGL` instruction is not vulnerable to a [Write-After-Read](https://en.wikipedia.org/wiki/Hazard_(computer_architecture)#Write_after_read_.28WAR.29) as the bus is locked for the duration of the exchange.
	XCHGL	AX, 0(BP)
	MOVL	AX, old+16(FP)
	RET
