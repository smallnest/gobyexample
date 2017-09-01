package main

// 下划线避免 `unusued package` 编译错误.
import _ "fmt"

func hello()

func main() {
    hello()
}
