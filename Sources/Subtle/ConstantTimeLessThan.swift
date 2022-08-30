public protocol ConstantTimeLessThan {
    static func < (lhs: Self, rhs: Self) -> Choice
}

public extension FixedWidthInteger where Self: UnsignedInteger {
    @inline(__always)
    static func < (lhs: Self, rhs: Self) -> Choice {
        var result = lhs &- rhs
        result ^= rhs
        result |= lhs ^ rhs
        result ^= lhs
        result >>= Self.bitWidth - 1
        return Choice(uncheckedRawValue: .init(truncatingIfNeeded: result))
    }
}

extension UInt:   ConstantTimeLessThan {}
extension UInt8:  ConstantTimeLessThan {}
extension UInt16: ConstantTimeLessThan {}
extension UInt32: ConstantTimeLessThan {}
extension UInt64: ConstantTimeLessThan {}

public protocol ConstantTimeLessThanOrEqualTo {
    static func <= (lhs: Self, rhs: Self) -> Choice
}

public extension ConstantTimeLessThanOrEqualTo where Self: ConstantTimeGreaterThan {
    @inline(__always)
    static func <= (lhs: Self, rhs: Self) -> Choice {
        !(lhs > rhs)
    }
}

extension UInt:   ConstantTimeLessThanOrEqualTo {}
extension UInt8:  ConstantTimeLessThanOrEqualTo {}
extension UInt16: ConstantTimeLessThanOrEqualTo {}
extension UInt32: ConstantTimeLessThanOrEqualTo {}
extension UInt64: ConstantTimeLessThanOrEqualTo {}
