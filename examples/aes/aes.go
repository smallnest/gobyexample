// 本例摘自标准库 [AES package](https://golang.org/pkg/crypto/aes/)，它使用汇编充分利用Intel的对AES的硬件支持，通过调用 AES-NI CPU 指令来实现。
// 它可以执行 AES算法的"循环"(round)加密和解密。

package aes

// `nr` 是 `src` 文本循环加密的次数， `xk` 指向包含`[]uint32`的第一个元素， 包含从主密钥派生出的128位循环key。`dst`指向加密结果的 `[]byte` slice。
func encryptBlockAsm(nr int, xk *uint32, dst, src *byte)
