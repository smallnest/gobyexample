#include "textflag.h"

// As you can see, the total length of the arguments and return values has been omitted: the last argument of `TEXT` could have been `$0-20`. This information is optional but advised as it can be easily checked via the `go vet` command line tool.
TEXT ·encryptBlockAsm(SB),NOSPLIT,$0
	MOVQ nr+0(FP), CX
	MOVQ xk+8(FP), AX
	MOVQ dst+16(FP), DX
	MOVQ src+24(FP), BX

	// `X0`, `X1`, ... are SSE registers allowing you to operate on large numbers (128-bit) via SIMD instructions. Lucky us, the sizes of the input, output and state of AES are always 128-bit. `MOVUPS` is used to load the first 128-bit round key pointed by `xk` (derived from the main key) and the input to the state `src` into these special registers. Before starting the encryption process, AES "whiten" the input (at this point still a plaintext) by XORing it with the first round key. This is done on the 128-bit registers via the the `PXOR` instruction. 
	MOVUPS 0(AX), X1
	MOVUPS 0(BX), X0
	ADDQ $16, AX // next round key
	PXOR X1, X0

	// AES accepts keys of various length: 128-bit, 192-bit and 256-bit. These three versions all accept a different number of rounds. We compare the `nr` argument with the number of rounds for AES-192 (12 rounds) to know what algorithm we're dealing with. If `nr` is equal to 12 (`JE`) we jump to the label `Lenc196`, if it's less (`JB`) we jump to the label `Lenc128`, if it's more we continue.
	SUBQ $12, CX
	JE Lenc196
	JB Lenc128
Lenc256:

	// A round always works the same way. The relevant 128-bit round key is loaded in a 128-bit SSE register (`X1`) then the `AESENC` instruction is called on the state (`X0`) and the subkey.
	MOVUPS 0(AX), X1
	AESENC X1, X0
	MOVUPS 16(AX), X1
	AESENC X1, X0
	ADDQ $32, AX // next round keys

// AES-256 has two more rounds compare to AES-196, so when the previous two operations are done we can fall through to the AES-192 branch of the code.
Lenc196:
	MOVUPS 0(AX), X1
	AESENC X1, X0
	MOVUPS 16(AX), X1
	AESENC X1, X0
	ADDQ $32, AX

// The previous note respectively applies to AES-192 and AES-128.
Lenc128:
	MOVUPS 0(AX), X1
	AESENC X1, X0
	MOVUPS 16(AX), X1
	AESENC X1, X0
	MOVUPS 32(AX), X1
	AESENC X1, X0
	MOVUPS 48(AX), X1
	AESENC X1, X0
	MOVUPS 64(AX), X1
	AESENC X1, X0
	MOVUPS 80(AX), X1
	AESENC X1, X0
	MOVUPS 96(AX), X1
	AESENC X1, X0
	MOVUPS 112(AX), X1
	AESENC X1, X0
	MOVUPS 128(AX), X1
	AESENC X1, X0
	MOVUPS 144(AX), X1
	AESENCLAST X1, X0
	MOVUPS X0, 0(DX)
	RET

