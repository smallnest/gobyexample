// 为了使用 `NOSPLIT` 这些常量， 下面的`#include`是必须的， [textflag.h](https://golang.org/src/runtime/textflag.h)中定义了一些常量值。
#include "textflag.h"


// 在这个例子中， 我们使用 `TEXT`指令包含三个参数，而不是第一个例子中的两个。 新的参数 `NOSPLIT` 是一种优化， 告诉编译器不需要栈扩展，如果没有这个参数，参数大小必须提供。 第三个参数指明了栈的大小。
TEXT ·Asin(SB),NOSPLIT,$0-16

  // 为了让 Arcsin 支持 `float64` 参数， 我们将会使用 FPU 寄存器。
  // `FMOVD` 设置 `F0` 和 `F1` 的值为 函数的输入参数 `x`。
  // F0=x
  // 官方库中的注释有点问题， 注释中应该是 sin(θ)， 输入参数x = sin(θ)
  FMOVD   x+0(FP), F0
  // F0=x, F1=x
  FMOVD   F0, F1

  // F0=x*x, F1=x
  FMULD   F0, F0      

  // `FLD1`将 +1.0 压入 FPU 的栈， 结果导致 `F0 = 1`, `F1 = F0` 和 `F2 = F1`。
  // F0=1, F1=x*x, F2=x
  FLD1

  // `FSUBRDP` 将 `F0` 减去 `F1` 的值， 存储在 `F1`中， 然后从 FPU 栈中弹出栈顶， 结果使 `F0 = F1`, `F1 = F2` 和 `F2 = NaN`。 
  // 也就是 `F0 = 1-x*x` 和 `F1 = x`. 
  FSUBRDP F0, F1 

  // `FSQRT` 计算 `F0`的平方根 ，结果存储在 `F0`
  FSQRT

  // `FPATAN`指令计算 `arctan(F1/F0)`, 弹出 FPU 栈顶， 计算结果放入到 `F0`， `F1` 为 `NaN`。
  // 其实就是利用公式 `arctan(x / sqrt(1 - x * x))` 计算 `arcsin(x)`的值。
  FPATAN

  // `FMOVDP` 将结果放入到返回结果的地址， 弹出 FPU的栈顶， 去除掉最后的 FPU 值`F0`。
  FMOVDP  F0, ret+8(FP)

  RET
