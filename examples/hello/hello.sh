<<<<<<< HEAD
// include 引入定义的一些常量， 例如我们后面使用的 `RODATA`。 其它一些预处理宏也可以使用, 比如 `#define`。
#include "textflag.h"

// 你可以将全局的word值放入`DATA`段中, 一次可以是1, 2, 4, 或者8个字节. 符号后面的`<>`限制数据在当前文件中。
DATA world<>+0(SB)/8, $"hello wo"
DATA world<>+8(SB)/4, $"rld "
// `GLOBL` 用来将地址设为全局的(global)， 并且是只读的 (`RODATA`), 相应的长度为 12。
=======
// This `#include` is needed to use Go Assembly's constants (for example the `RODATA` that we use later on). Other pre-processor macros can be used in Go Assembly (like `#define`).
#include "textflag.h"

// `DATA` allows you to store global words in memory 1, 2, 4 or 8 bytes at a time. The <> after the symbol name restricts the data to the current file.
DATA world<>+0(SB)/8, $"hello wo"
DATA world<>+8(SB)/4, $"rld "
// `GLOBL` makes the data global and read-only (`RODATA`) for the relevant length (12).
>>>>>>> 39dc28f0d2d41769af81572ee7a2ca9ca7d7b321
GLOBL world<>+0(SB), RODATA, $12
	
TEXT ·hello(SB),$88-0
	SUBQ	$88, SP
	MOVQ	BP, 80(SP)
	LEAQ	80(SP), BP
	// 创建一个go字符 my_string（指向字符串的指针，紧跟着字符串的长度）
	LEAQ	world<>+0(SB), AX 
	MOVQ	AX, my_string+48(SP)        
	MOVQ	$11, my_string+56(SP)
	MOVQ	$0, autotmp_0+64(SP)
	MOVQ	$0, autotmp_0+72(SP)
	LEAQ	type·string(SB), AX
	MOVQ	AX, (SP)
	LEAQ	my_string+48(SP), AX        
	MOVQ	AX, 8(SP)
    // 调用 `runtime` 的函数 `convT2E`, 返回一个接口
	CALL	runtime·convT2E(SB)           
	MOVQ	24(SP), AX
	MOVQ	16(SP), CX                    
	MOVQ	CX, autotmp_0+64(SP)        
	MOVQ	AX, autotmp_0+72(SP)
	LEAQ	autotmp_0+64(SP), AX        
	MOVQ	AX, (SP)                      
	MOVQ	$1, 8(SP)                      
	MOVQ	$1, 16(SP)
<<<<<<< HEAD
	// 调用fmt·Println 打印接口内容
	CALL	fmt·Println(SB)
	// 代码相当的复杂， 教训就是尽量不要在go 汇编中调用函数
=======
	// `fmt.Println` is called with the interface created
	CALL	fmt·Println(SB)
	// This is pretty complicated, the lesson here is: don't try to call functions from Go's assembly. 
>>>>>>> 39dc28f0d2d41769af81572ee7a2ca9ca7d7b321
	MOVQ 80(SP), BP
	ADDQ $88, SP
	RET
