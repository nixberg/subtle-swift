public struct Choice {
    public static let `true`  = Choice(uncheckedRawValue: 0b1)
    public static let `false` = Choice(uncheckedRawValue: 0b0)
    
    fileprivate let rawValue: UInt8
    
    @inline(__always)
    public init(_ source: Self) {
        self = source
    }
    
    @inline(never) // TODO: Is this enough?
    public init(uncheckedRawValue rawValue: UInt8) {
        assert(rawValue == 0b1 || rawValue == 0b0)
        self.rawValue = rawValue
    }
    
    @inline(__always)
    public prefix static func ! (operand: Self) -> Self {
        Self(uncheckedRawValue: operand.rawValue ^ 0x01)
    }
    
    @inline(__always)
    public static func && (lhs: Self, rhs: Self) -> Self {
        Self(uncheckedRawValue: lhs.rawValue & rhs.rawValue)
    }
    
    @inline(__always)
    public static func || (lhs: Self, rhs: Self) -> Self {
        Self(uncheckedRawValue: lhs.rawValue | rhs.rawValue)
    }
}

public extension Bool {
    @inline(__always)
    init(_ source: Choice) {
        self = (source.rawValue == Choice.true.rawValue)
    }
}

extension FixedWidthInteger where Self: UnsignedInteger {
    @inline(__always)
    init(maskFrom choice: Choice) {
        self = 0 &- Self(truncatingIfNeeded: choice.rawValue)
    }
}
