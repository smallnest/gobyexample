// amd64p32 是 native client (Nacl) amd64 指令集，使用32位地址空间， 32位的指针， 32位的int和uint。它是play.golang.org的沙箱架构。
∕∕ `sqrt_amd64p32.s`

// 因为 amd64 汇编文件可以使用，所以这里我们包含它。
#include "sqrt_amd64.s"
