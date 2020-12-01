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
            
            _ = sequence(first: top) { $0 >> 1 }.prefix { $0 > p }.reduce(0) { offset, q in
                for i in offset..<(count - q) where i & p == 0 {
                    self[i + p] = sequence(first: q) {
                        $0 >> 1
                    }.prefix {
                        $0 > p
                    }.reduce(self[i + p]) { (a, r) in
                        self.minmax(a, i + r)
                    }
                }
                return count - q
            }
        }
    }
    
    @inline(__always)
    private mutating func minmaxAt(_ i: Index, _ j: Index) {
        let a = self[i]
        let b = self[j]
        let swapOperator = (a ^ b) & Element(maskFrom: a > b)
        self[i] = a ^ swapOperator
        self[j] = b ^ swapOperator
    }
    
    @inline(__always)
    private mutating func minmax(_ a: Element, _ j: Index) -> Element {
        let b = self[j]
        let swapOperator = (a ^ b) & Element(maskFrom: a > b)
        self[j] = b ^ swapOperator
        return a ^ swapOperator
    }
}
