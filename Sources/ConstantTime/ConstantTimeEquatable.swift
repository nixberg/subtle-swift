public protocol ConstantTimeEquatable {
    static func == (lhs: Self, rhs: Self) -> Choice
    
    static func != (lhs: Self, rhs: Self) -> Choice
}

public extension ConstantTimeEquatable {
    @inline(__always)
    static func != (lhs: Self, rhs: Self) -> Choice {
        !(lhs == rhs)
    }
}

public extension FixedWidthInteger where Self: UnsignedInteger {
    @inline(__always)
    static func == (lhs: Self, rhs: Self) -> Choice {
        var result = lhs ^ rhs
        result |= 0 &- result
        result >>= Self.bitWidth - 1
        return !Choice(uncheckedRawValue: UInt8(truncatingIfNeeded: result))
    }
}

extension UInt:   ConstantTimeEquatable {}
extension UInt8:  ConstantTimeEquatable {}
extension UInt16: ConstantTimeEquatable {}
extension UInt32: ConstantTimeEquatable {}
extension UInt64: ConstantTimeEquatable {}