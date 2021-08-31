public protocol ConditionallyNegatable {
    func negated(if choice: Choice) -> Self
    
    mutating func negate(if choice: Choice)
}

public extension ConditionallyNegatable {
    @inline(__always)
    mutating func negate(if choice: Choice) {
        self = self.negated(if: choice)
    }
}

public extension FixedWidthInteger where Self: UnsignedInteger {
    @inline(__always)
    func negated(if choice: Choice) -> Self {
        self.replaced(with: 0 &- self, if: choice)
    }
}

extension UInt:   ConditionallyNegatable {}
extension UInt8:  ConditionallyNegatable {}
extension UInt16: ConditionallyNegatable {}
extension UInt32: ConditionallyNegatable {}
extension UInt64: ConditionallyNegatable {}
