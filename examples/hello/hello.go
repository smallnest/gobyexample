// The following example is a bad example. It was obtained by using the following command on a simple Go program printing the string "hello world":
// ```
// go tool compile -S helloworld.go
// ```

package main

// The underscore _ is to avoid an "unusued package" compiler error.
import _ "fmt"

func hello()

func main() {
    hello()
}
