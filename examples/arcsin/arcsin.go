// 下面的例子实现了 [Arcsin](https://zh.wikipedia.org/wiki/反正弦)函数，也就是正弦函数 `sin` 的反函数。 代码摘自[标准库](https://golang.org/src/math/asin_386.s)。

package main

import (
    "fmt"
)

func Asin(x float64) float64

func main() {
    fmt.Println(Asin(1))
}
