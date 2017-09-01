// This example is taken from the [sync/atomic](https://golang.org/pkg/sync/atomic/) package which provides low-level atomic memory primitives.
// The swap operation, implemented by the SwapT functions, is the atomic equivalent of
// ```c
// old = *addr
// *addr = new
// return old
// ```

package atomic

import (
    "unsafe"
)

// SwapInt32 atomically stores new into *addr and returns the previous *addr value.
func SwapInt32(addr *int32, new int32) (old int32)
