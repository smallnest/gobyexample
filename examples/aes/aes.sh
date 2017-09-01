#include "textflag.h"

// 本例设计AES算法的一些术语，翻译的比较勉强，如有错误，欢迎指正。
// 如你所见， 参数和返回结果的整体长度被忽略了，`TEXT`的最后的参数可以是`$0-20`。这个信息是可选的, 但是推荐写， 因为它可以通过 `go vet`很容的检查。
TEXT ·encryptBlockAsm(SB),NOSPLIT,$0
	MOVQ nr+0(FP), CX
	MOVQ xk+8(FP), AX
	MOVQ dst+16(FP), DX
	MOVQ src+24(FP), BX

	// `X0`, `X1`, ...是 SSE 寄存器， 允许你通过 SIMD 指令操作大数 (128位)。幸运地是，AES的输入输出和状态都是128位的。`MOVUPS` 用来加载由`xk`指向的第一个128位的 round  key，还有状态`src`都加载到特殊的寄存器中。在开始加密之前， AES 使用`XOR`和第一轮的key `whiten` 输入的文本， 这通过128位的寄存器`PXOR`完成。
	MOVUPS 0(AX), X1
	MOVUPS 0(BX), X0
	ADDQ $16, AX // next round key
	PXOR X1, X0

	// AES 接受各种变长的key：128位、192位、256位。这三种变长都接受一个不同数量的round。我们通过比较`nr`和AES-192的round数值，就可以知道我们处理的那种变长的算法。如果`nr`等于 12，我们就会跳到标签`Lenc196`处的代码，如果小于我们就跳到`Lenc128`，如果大于则继续处理。
	SUBQ $12, CX
	JE Lenc196
	JB Lenc128
Lenc256:

	// 一轮的处理总是使用相同的方式。相应的128位round key被加载到128位 SSE 寄存器中(`X1`)，然后`AESENC`指令被调用处理状态`X0`和subkey。
	MOVUPS 0(AX), X1
	AESENC X1, X0
	MOVUPS 16(AX), X1
	AESENC X1, X0
	ADDQ $32, AX // next round keys

// AES-256 比 AES-196 要多两轮，所以当前两个操作做完后，很自然继续 AES-192的分支。
Lenc196:
	MOVUPS 0(AX), X1
	AESENC X1, X0
	MOVUPS 16(AX), X1
	AESENC X1, X0
	ADDQ $32, AX

// 同样的道理前面两个case还要执行这个分支。
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

