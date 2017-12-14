package noescape

//此处使用go编译器的指示
//go:noescape
func noescape(d []byte) (b []byte)

func test() int {
    var buf [1024]byte

    // `go:noescape`可以确保data分配在栈上
    data := noescape(buf[:])

    // do something in data
    // 这样可以确保buf一定分配在函数test的函数栈上

    return len(data)
}
