// +build amd64 amd64p32
// +build go1.5

// 这个例子摘自 [goid](https://github.com/petermattis/goid), 演示了如果访问runtime内部的数据结构。

package goid

// 获取 goroutine ID的方法签名.
func Get() int64
