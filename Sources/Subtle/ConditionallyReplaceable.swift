public protocol ConditionallyReplaceable {
    func replaced(with other: Self, if choice: Choice) -> Self
    
    mutating func replace(with other: Self, if choice: Choice)
    
    func swapped(with other: Self, if choice: Choice) -> (Self, Self)
    
    mutating func swap(with other: inout Self, if choice: Choice)
}

public extension ConditionallyReplaceable {
    @inline(__always)
    mutating func replace(with other: Self, if choice: Choice) {
        self = self.replaced(with: other, if: choice)
    }
    
    @inline(__always)
    mutating func swap(with other: inout Self, if choice: Choice) {
        (self, other) = self.swapped(with: other, if: choice)
    }
    
    @inline(__always)
    func swapped(with other: Self, if choice: Choice) -> (Self, Self) {
        (self.replaced(with: other, if: choice), other.replaced(with: self, if: choice))
    }
}

extension Choice: ConditionallyReplaceable {
    @inline(__always)
    public func replaced(with other: Choice, if choice: Choice) -> Choice {
        (self && !choice) || (other && choice)
    }
}

extension FixedWidthInteger where Self: UnsignedInteger {
    @inline(__always)
    public func replaced(with other: Self, if choice: Choice) -> Self {
        let mask = Self(maskFrom: choice)
        return (self & ~mask) | (other & mask)
    }
    
    @inline(__always)
    fileprivate func _swapped(with other: Self, if choice: Choice) -> (Self, Self) {
        let swapOperator = (self ^ other) & Self(maskFrom: choice)
        return (self ^ swapOperator, other ^ swapOperator)
    }
}

extension UInt: ConditionallyReplaceable {
    @inline(__always)
    public func swapped(with other: Self, if choice: Choice) -> (Self, Self) {
        self._swapped(with: other, if: choice)
    }
}

extension UInt8: ConditionallyReplaceable {
    @inline(__always)
    public func swapped(with other: Self, if choice: Choice) -> (Self, Self) {
        self._swapped(with: other, if: choice)
    }
}

extension UInt16: ConditionallyReplaceable {
    @inline(__always)
    public func swapped(with other: Self, if choice: Choice) -> (Self, Self) {
        self._swapped(with: other, if: choice)
    }
}

extension UInt32: ConditionallyReplaceable {
    @inline(__always)
    public func swapped(with other: Self, if choice: Choice) -> (Self, Self) {
        self._swapped(with: other, if: choice)
    }
}

extension UInt64: ConditionallyReplaceable {
    @inline(__always)
    public func swapped(with other: Self, if choice: Choice) -> (Self, Self) {
        self._swapped(with: other, if: choice)
    }
}

extension MutableCollection where Element: ConditionallyReplaceable {
    @inline(__always)
    public mutating func replace(with other: Self, if choice: Choice) {
        precondition(count == other.count)
        for (i, element) in zip(indices, other) {
            self[i].replace(with: element, if: choice)
        }
    }
}
