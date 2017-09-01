// 这个例子摘自 [sync/atomic](https://golang.org/pkg/sync/atomic/), 提供了底层的原子操作.
// SwapT 函数实现了 swap 操作。
// 1. old = *addr
// 2.  *addr = new
// 3. return old

package atomic

// SwapInt32 自动保存新值到 *addr 并且返回先前的 *addr 的值.
func SwapInt32(addr *int32, new int32) (old int32)
