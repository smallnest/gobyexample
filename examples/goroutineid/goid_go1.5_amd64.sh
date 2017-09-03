// +build amd64 amd64p32
// +build go1.5

#include "go_asm.h"
#include "textflag.h"

// 函数 Get() int64的实现
TEXT ·Get(SB),NOSPLIT,$0-8
	// TLS 其实是线程本地存储 （Thread Local Storage ）的缩写。在 Go 语言中，TLS 存储了一个 G 结构体的指针。
	// 也可以使用宏 `get_tls(R14)` 来实现。
	// 下面的指令其实是将g的指针放入 `R14` 寄存器
	MOVQ (TLS), R14
	// 利用宏`g_goid`获取goroutine的id,并将结果存入到 寄存器 `R13`
	MOVQ g_goid(R14), R13
	// 将结果返回
	MOVQ R13, ret+0(FP)
	RET