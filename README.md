![Swift](https://github.com/nixberg/constant-time-swift/workflows/Swift/badge.svg)

# constant-time-swift

Experimental, do not use.

## Usage

`.sortInConstantTime()` is declared `@inline(__always)`—consider wrapping it in a function.
`-cross-module-optimization` should resolve this eventually.

## References

- [github.com/veorq/cryptocoding](https://github.com/veorq/cryptocoding)

- [github.com/dalek-cryptography/subtle](https://github.com/dalek-cryptography/subtle)

- [djbsort](https://sorting.cr.yp.to/)
