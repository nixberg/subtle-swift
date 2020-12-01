// Adapted from https://sorting.cr.yp.to

public extension Array where Element: FixedWidthInteger & UnsignedInteger {
    @inline(never)
    mutating func sortInConstantTime() {
        guard let top = sequence(first: 1) { 2 * $0 }.prefix(while: { $0 < count }).last else {
            return
        }
        
        sequence(first: top) { $0 >> 1 }.prefix { $0 > 0 }.forEach { p in
            for i in 0..<(count - p) where i & p == 0 {
                self.minmaxAt(i, i + p)
            }
            
            var offset = 0
            
            sequence(first: top) { $0 >> 1 }.prefix { $0 > p }.forEach { q in
                for i in offset..<(count - q) where i & p == 0 {
                    self[i + p] = sequence(first: q) {
                        $0 >> 1
                    }.prefix {
                        $0 > p
                    }.reduce(into: self[i + p]) { (a, r) in
                        minmax(&a, &self[i + r])
                    }
                }
                offset = count - q
            }
        }
    }
}

fileprivate extension Array where Element: FixedWidthInteger & UnsignedInteger {
    @inline(__always)
    mutating func minmaxAt(_ i: Int, _ j: Int) {
        let a = self[i]
        let b = self[j]
        let swapOperator = (a ^ b) & Element(maskFrom: a > b)
        self[i] = a ^ swapOperator
        self[j] = b ^ swapOperator
    }
}

@inline(__always)
fileprivate func minmax<T>(_ a: inout T, _ b: inout T)
where T: FixedWidthInteger & UnsignedInteger {
    let swapOperator = (a ^ b) & T(maskFrom: a > b)
    a ^= swapOperator
    b ^= swapOperator
}
