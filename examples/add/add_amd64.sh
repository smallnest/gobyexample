// 通过 `TEXT package_name·function_name(SB),$frame_size-arguments_size` 模式声明了 `add` 方法。
// 注意这里包名 (package name) 是空的， 对应当前的包， 注意其中那个是中间点`·` (U+00B7, 一些外国人的名字中间常用这个标点， MAC用shift option 9输入， 一般其它输入法「Shift-2」或叹号!左边的那个「\`」)， 而不是句点 `.`。
// `$0` 指定了栈空间所需的 `frame size`（0代表我们只使用寄存器)。
// `frame size` 之后是一个减号(不是真的做减法，而是一个助记符)， 后面跟的数字代表参数和返回值 (argument) 的大小。 本例中参数和返回值占用 3*8 个字节 (它们存在于调用者 caller 的栈内)。
TEXT ·add(SB),$0-24
	// `MOVQ` 指令用来移动64位的值 (Q代表 `QUADWORD`)。这里是将基于栈指针 `FP` (指向函数参数)的一个偏移中的数据移动到寄存器 `BX` 和 `BP` 中。
	// 语法格式为 `symbol+offset(register)`, 这里 `(register)` 是 `(register)`的地址。 例如第二行是将 `*(FP + 8)` 的内容移动到 `BP`。 注意这里的 `x` 和 `y` 是函数原型中的参数的名称。
	MOVQ x+0(FP), BX
	MOVQ y+8(FP), BP
	// `ADDQ` 指令对两个64位的寄存器中的值做加法， 结果存储到 `BX` 中。
	ADDQ BP, BX
	// 结果移动到 `*(FP + 16)`, 这个地址是返回结果的地址 (位置在所有的参数之后)。注意我们使用 `ret`符号代表结果符号， 编译器所要求的格式。
	MOVQ BX, ret+16(FP)
	// 最后一个指令就是简单的返回给调用者
	RET
	
