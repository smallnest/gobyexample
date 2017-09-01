// The following example is a bad example. It was obtained by using the following command on a simple Go program printing the string "hello world":
// ```
// go tool compile -S helloworld.go
// ```

package main

// 下划线避免 `unusued package` 编译错误.
import _ "fmt"

func hello()

func main() {
    hello()
}
