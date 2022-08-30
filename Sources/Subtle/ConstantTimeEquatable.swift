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

extension FixedWidthInteger {
    @inline(__always)
    public static func == (lhs: Self, rhs: Self) -> Choice {
        !(lhs != rhs)
    }
    
    @inline(__always)
    public static func != (lhs: Self, rhs: Self) -> Choice {
        let lhs = Magnitude(truncatingIfNeeded: lhs)
        let rhs = Magnitude(truncatingIfNeeded: rhs)
        var result = lhs ^ rhs
        result |= 0 &- result
        result >>= Magnitude.bitWidth - 1
        return Choice(uncheckedRawValue: .init(truncatingIfNeeded: result))
    }
}

extension Int:   ConstantTimeEquatable {}
extension Int8:  ConstantTimeEquatable {}
extension Int16: ConstantTimeEquatable {}
extension Int32: ConstantTimeEquatable {}
extension Int64: ConstantTimeEquatable {}

extension UInt:   ConstantTimeEquatable {}
extension UInt8:  ConstantTimeEquatable {}
extension UInt16: ConstantTimeEquatable {}
extension UInt32: ConstantTimeEquatable {}
extension UInt64: ConstantTimeEquatable {}

extension Sequence where Element: ConstantTimeEquatable {
    public static func == (lhs: Self, rhs: Self) -> Choice {
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
    public static func != (lhs: Self, rhs: Self) -> Choice {
        !(lhs == rhs)
    }
}

extension RandomAccessCollection where Element: ConstantTimeEquatable {
    public static func == (lhs: Self, rhs: Self) -> Choice {
        precondition(lhs.count == rhs.count)
        return zip(lhs, rhs).map(==).reduce(.true, &&)
    }
    
    @inline(__always)
    public static func != (lhs: Self, rhs: Self) -> Choice {
        !(lhs == rhs)
    }
}

extension Array: ConstantTimeEquatable where Element: ConstantTimeEquatable {}

extension ArraySlice: ConstantTimeEquatable where Element: ConstantTimeEquatable {}

extension ContiguousArray: ConstantTimeEquatable where Element: ConstantTimeEquatable {}

extension Slice: ConstantTimeEquatable where Base: Sequence, Base.Element: ConstantTimeEquatable {}

extension UnsafeMutablePointer: ConstantTimeEquatable where Pointee: ConstantTimeEquatable {
    @inline(__always)
    public static func == (lhs: Self, rhs: Self) -> Choice {
        lhs.pointee == rhs.pointee
    }
    
    @inline(__always)
    public static func != (lhs: Self, rhs: Self) -> Choice {
        !(lhs == rhs)
    }
}

extension UnsafeBufferPointer: ConstantTimeEquatable where Element: ConstantTimeEquatable {}

extension UnsafeMutableBufferPointer: ConstantTimeEquatable where Element: ConstantTimeEquatable {}

extension UnsafeRawBufferPointer: ConstantTimeEquatable {}

extension UnsafeMutableRawBufferPointer: ConstantTimeEquatable {}
