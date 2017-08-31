// The following example is the implementation of the [Arcsin](https://en.wikipedia.org/wiki/Inverse_trigonometric_functions) function (the inverse of sin) taken from the [standard Go library](https://golang.org/src/math/asin_386.s).

package main

import (
    "fmt"
)

func Asin(x float64) float64

func main() {
    fmt.Println(Asin(1))
}
