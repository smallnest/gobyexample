// This `#include` is needed to use Go Assembly's constants (for example the `RODATA` that we use later on). Other pre-processor macros can be used in Go Assembly (like `#define`).
#include "textflag.h"

// `DATA` allows you to store global words in memory 1, 2, 4 or 8 bytes at a time. The <> after the symbol name restricts the data to the current file.
DATA world<>+0(SB)/8, $"hello wo"
DATA world<>+8(SB)/4, $"rld "
// `GLOBL` makes the data global and read-only (`RODATA`) for the relevant length (12).
GLOBL world<>+0(SB), RODATA, $12
	
TEXT ·hello(SB),$88-0
	SUBQ	$88, SP
	MOVQ	BP, 80(SP)
	LEAQ	80(SP), BP
	// A Go string is created in my_string (a pointer to the string followed by the string's length).
	LEAQ	world<>+0(SB), AX 
	MOVQ	AX, my_string+48(SP)        
	MOVQ	$11, my_string+56(SP)
	MOVQ	$0, autotmp_0+64(SP)
	MOVQ	$0, autotmp_0+72(SP)
	LEAQ	type·string(SB), AX
	MOVQ	AX, (SP)
	LEAQ	my_string+48(SP), AX        
	MOVQ	AX, 8(SP)
  // `convT2E` from the `runtime` package is used to create an interface.
	CALL	runtime·convT2E(SB)           
	MOVQ	24(SP), AX
	MOVQ	16(SP), CX                    
	MOVQ	CX, autotmp_0+64(SP)        
	MOVQ	AX, autotmp_0+72(SP)
	LEAQ	autotmp_0+64(SP), AX        
	MOVQ	AX, (SP)                      
	MOVQ	$1, 8(SP)                      
	MOVQ	$1, 16(SP)
	// `fmt.Println` is called with the interface created
	CALL	fmt·Println(SB)
	// This is pretty complicated, the lesson here is: don't try to call functions from Go's assembly. 
	MOVQ 80(SP), BP
	ADDQ $88, SP
	RET
