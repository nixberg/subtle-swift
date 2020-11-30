public struct Choice {
    public static let `true`  = Choice(unsafeRawValue: 0x01)
    public static let `false` = Choice(unsafeRawValue: 0x00)
    
    fileprivate let rawValue: UInt8
    
    public init(_ source: Self) {
        self = source
    }
    
    @inline(never)
    public init(unsafeRawValue rawValue: UInt8) {
        assert(rawValue & 0x01 == rawValue)
        self.rawValue = rawValue
    }
    
    @inline(never)
    public prefix static func ! (operand: Self) -> Self {
        Self(unsafeRawValue: operand.rawValue ^ 0x01)
    }
    
    @inline(never)
    public static func && (lhs: Self, rhs: Self) -> Self {
        Self(unsafeRawValue: lhs.rawValue & rhs.rawValue)
    }
    
    @inline(never)
    public static func || (lhs: Self, rhs: Self) -> Self {
        Self(unsafeRawValue: lhs.rawValue | rhs.rawValue)
    }
}

public extension Bool {
    @inline(never)
    init(_ source: Choice) {
        self = source.rawValue == 0x01
    }
}

// Adapted from https://github.com/veorq/cryptocoding

public extension FixedWidthInteger where Self: UnsignedInteger {
    @inline(never)
    init(maskFrom choice: Choice) {
        self = 0 &- Self(truncatingIfNeeded: choice.rawValue)
    }
    
    @inline(never)
    var isZero: Choice {
        var result = self
        result |= 0 &- self
        result >>= Self.bitWidth - 1
        return Choice(unsafeRawValue: UInt8(truncatingIfNeeded: result) ^ 0x01)
    }
    
    @inline(__always)
    static func == (lhs: Self, rhs: Self) -> Choice {
        !(lhs != rhs)
    }
    
    @inline(never)
    static func != (lhs: Self, rhs: Self) -> Choice {
        var result = lhs ^ rhs
        result |= 0 &- result
        result >>= Self.bitWidth - 1
        return Choice(unsafeRawValue: UInt8(truncatingIfNeeded: result))
    }
    
    @inline(never)
    static func < (lhs: Self, rhs: Self) -> Choice {
        var result = lhs &- rhs
        result ^= rhs
        result |= lhs ^ rhs
        result ^= lhs
        result >>= Self.bitWidth - 1
        return Choice(unsafeRawValue: UInt8(truncatingIfNeeded: result))
    }
    
    @inline(__always)
    static func <= (lhs: Self, rhs: Self) -> Choice {
        !(lhs > rhs)
    }
    
    @inline(__always)
    static func > (lhs: Self, rhs: Self) -> Choice {
        rhs < lhs
    }
    
    @inline(__always)
    static func >= (lhs: Self, rhs: Self) -> Choice {
        !(lhs < rhs)
    }
}
