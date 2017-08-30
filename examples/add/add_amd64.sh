// We declare the `add` function via the `TEXT package_name·function_name(SB),$frame_size-arguments_size` pattern. Notice that the package name is empty here, corresponding to the current package, and a middle point `·` is used (U+00B7) not a period. The frame size of `$0` at the end indicates the stack space needed (none, we'll just use registers), while the arguments to the function and the return value take 3*8 bytes in total (they live on the caller's stack).
TEXT ·add(SB),$0-24
  // The `MOVQ` instruction is used to move a 64-bit value (Q stands for QUADWORD) around. Here from an offset of the frame pointer `FP` (used to refer to function arguments) to a register (`BX` and `BP`). The syntax `symbol+offset(register)` is used, where `(register)` is the address pointed by the `register`. For example, on the second line the content at `*(FP + 8)` is moved into `BP`. Note that `x` and `y` are the arguments' names in the function's prototype. 
	MOVQ x+0(FP), BX
	MOVQ y+8(FP), BP
  // The `ADDQ` instruction is used to add the two 64-bit registers together, it then stores the result in `BX`.
	ADDQ BP, BX
  // The result is moved at address `*(FP + 16)` which is the address of the return value (positioned after all the arguments). Note that we named the symbol `ret` as a symbol is always required by the compiler.
	MOVQ BX, ret+16(FP)
	// The last instruction simply returns to the caller.
	RET
	
