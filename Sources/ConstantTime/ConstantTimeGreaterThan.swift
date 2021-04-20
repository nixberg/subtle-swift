public protocol ConstantTimeGreaterThan {
    static func > (lhs: Self, rhs: Self) -> Choice
}

public extension FixedWidthInteger where Self: UnsignedInteger {
    @inline(__always)
    static func > (lhs: Self, rhs: Self) -> Choice {
        var result = rhs &- lhs
        result ^= lhs
        result |= rhs ^ lhs
        result ^= rhs
        result >>= Self.bitWidth - 1
        return Choice(uncheckedRawValue: UInt8(truncatingIfNeeded: result))
    }
}

extension UInt:   ConstantTimeGreaterThan {}
extension UInt8:  ConstantTimeGreaterThan {}
extension UInt16: ConstantTimeGreaterThan {}
extension UInt32: ConstantTimeGreaterThan {}
extension UInt64: ConstantTimeGreaterThan {}

public protocol ConstantTimeGreaterThanOrEqualTo {
    static func >= (lhs: Self, rhs: Self) -> Choice
}

public extension ConstantTimeGreaterThanOrEqualTo where Self: ConstantTimeLessThan {
    @inline(__always)
    static func >= (lhs: Self, rhs: Self) -> Choice {
        !(lhs < rhs)
    }
}

extension UInt:   ConstantTimeGreaterThanOrEqualTo {}
extension UInt8:  ConstantTimeGreaterThanOrEqualTo {}
extension UInt16: ConstantTimeGreaterThanOrEqualTo {}
extension UInt32: ConstantTimeGreaterThanOrEqualTo {}
extension UInt64: ConstantTimeGreaterThanOrEqualTo {}
