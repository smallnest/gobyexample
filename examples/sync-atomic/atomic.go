<<<<<<< HEAD
// 这个例子摘自 [sync/atomic](https://golang.org/pkg/sync/atomic/), 提供了底层的原子操作.
// SwapT 函数实现了 swap 操作。
// 1. old = *addr
// 2.  *addr = new
// 3. return old
=======
// This example is taken from the [sync/atomic](https://golang.org/pkg/sync/atomic/) package which provides low-level atomic memory primitives.
// The swap operation, implemented by the SwapT functions, is the atomic equivalent of
// ```c
// old = *addr
// *addr = new
// return old
// ```
>>>>>>> 39dc28f0d2d41769af81572ee7a2ca9ca7d7b321

package atomic

// SwapInt32 自动保存新值到 *addr 并且返回先前的 *addr 的值.
func SwapInt32(addr *int32, new int32) (old int32)
