public protocol ConstantTimeEquatable {
    static func == (lhs: Self, rhs: Self) -> Choice
    
    static func != (lhs: Self, rhs: Self) -> Choice
}

extension Choice: ConstantTimeEquatable {
    @inline(__always)
    public static func == (lhs: Self, rhs: Self) -> Choice {
        !(lhs != rhs)
    }
    
    @inline(__always)
    public static func != (lhs: Self, rhs: Self) -> Choice {
        Self(uncheckedRawValue: lhs.rawValue ^ rhs.rawValue)
    }
}

public extension FixedWidthInteger where Self: UnsignedInteger {
    @inline(__always)
    static func == (lhs: Self, rhs: Self) -> Choice {
        !(lhs != rhs)
    }
    
    @inline(__always)
    static func != (lhs: Self, rhs: Self) -> Choice {
        var result = lhs ^ rhs
        result |= 0 &- result
        result >>= Self.bitWidth - 1
        return Choice(uncheckedRawValue: UInt8(truncatingIfNeeded: result))
    }
}

extension UInt:   ConstantTimeEquatable {}
extension UInt8:  ConstantTimeEquatable {}
extension UInt16: ConstantTimeEquatable {}
extension UInt32: ConstantTimeEquatable {}
extension UInt64: ConstantTimeEquatable {}

public extension Sequence where Element: ConstantTimeEquatable {
    static func == (lhs: Self, rhs: Self) -> Choice {
        var lhs = lhs.makeIterator()
        var rhs = rhs.makeIterator()
        
        var result: Choice = .true
        
        while true {
            switch (lhs.next(), rhs.next()) {
            case (let lhs?, let rhs?):
                result &&= lhs == rhs
            case (.some, .none):
                preconditionFailure()
            case (.none, .some):
                preconditionFailure()
            case (.none, .none):
                return result
            }
        }
    }
    
    @inline(__always)
    static func != (lhs: Self, rhs: Self) -> Choice {
        !(lhs == rhs)
    }
}

public extension RandomAccessCollection where Element: ConstantTimeEquatable {
    static func == (lhs: Self, rhs: Self) -> Choice {
        precondition(lhs.count == rhs.count)
        return zip(lhs, rhs).map(==).reduce(.true, &&)
    }
    
    @inline(__always)
    static func != (lhs: Self, rhs: Self) -> Choice {
        !(lhs == rhs)
    }
}
