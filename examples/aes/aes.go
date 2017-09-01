// This example is taken from the [AES package](https://golang.org/pkg/crypto/aes/) of the standard Go library.
// It makes use of Go Assembly to leverage Intel's hardware support for AES, calling the AES-NI CPU instructions
// that can perform a "round" of encryption or decrpytion of the AES algorithm.

package aes

// `nr` is the number of rounds that the `src` plaintext will go through to get encrypted. `xk` points to the first element of a `[]uint32` slice containing all the 128-bit round keys that were derived from the main key. `dst` points to a `[]byte` slice that will be written with the resulting ciphertext.
func encryptBlockAsm(nr int, xk *uint32, dst, src *byte)
