// 这个例子摘自标准库 [math package](https://golang.org/pkg/math/#Sqrt)。
// 函数在不同的汇编文件中来实现，这是因为要使用不同架构下的硬件对开方根函数的支持。

package math

func Sqrt(x float64) float64
