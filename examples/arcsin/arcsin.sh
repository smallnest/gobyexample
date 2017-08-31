// This `#include` is required to use Go Assembly's constants like `NOSPLIT`. Otherwise their associated number can be used instead (`NOSPLIT=4`).
#include "textflag.h"

// In this example, we use the `TEXT` instruction with 3 arguments instead of 2. The new argument `NOSPLIT` is an optimization to warn the compiler that no expansion of the stack will be needed. Indeed, the third argument indicates a stack of 0 bytes.
TEXT ·Asin(SB),NOSPLIT,$0-16

  // To implement the Arcsin function on a `float64` argument, the FPU registers will be used. 
  // `FMOVD` sets `F0` and `F1` to the function's input `x`.
  FMOVD   x+0(FP), F0
  FMOVD   F0, F1

  FMULD   F0, F0      

  // `FLD1` pushes +1.0 onto the FPU stack. This makes `F0 = 1`, `F1 = F0` and `F2 = F1`.
  FLD1

  // `FSUBRDP` substracts `F0` to `F1` and stores it in `F1`. It then pops the FPU stack, this makes `F0 = F1`, `F1 = F2` and `F2 = NaN`.  
	// In other words: `F0 = 1-x*x` and `F1 = x`.
  FSUBRDP F0, F1 

  // `FSQRT` computes the square root of `F0` and stores it in `F0`.
  FSQRT

  // `FPATAN` computes `arctan(F1/F0)` and stores it in `F1`, then it pops the FPU stack placing the result in `F0` and setting `F1` to `NaN`.  
	// This gives us  `arctan(x / sqrt(1 - x * x))` which is a way to compute the arcsin function on `x`.
  FPATAN

  // `FMOVDP` moves the result to the return address (the memory offset from `FP` after the argument of 64-bit) and pops the FPU stack, getting rid of the last FPU value `F0`.
  FMOVDP  F0, ret+8(FP)

  RET
