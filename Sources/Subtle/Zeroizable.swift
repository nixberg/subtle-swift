public protocol Zeroizable {
    mutating func zeroize()
}

extension MutableCollection where Element: Zeroizable {
    public mutating func zeroize() {
        for index in indices {
            self[index].zeroize()
        }
    }
}

extension Array: Zeroizable where Element: Zeroizable {}

extension ArraySlice: Zeroizable where Element: Zeroizable {}

extension ContiguousArray: Zeroizable where Element: Zeroizable {}

extension Slice: Zeroizable where Base: MutableCollection, Base.Element: Zeroizable {}

extension UnsafeMutableBufferPointer: Zeroizable where Element: Zeroizable {}

// MARK: -

#if canImport(Darwin) || canImport(Glibc)

#if canImport(Darwin)
import Darwin
extension UnsafeMutableRawBufferPointer: Zeroizable {
    public func zeroize() {
        let errorNumber = memset_s(baseAddress!, count, 0, count)
        guard errorNumber == 0 else {
            fatalError("memset_s failed with error number \(errorNumber)")
        }
    }
}
#elseif canImport(Glibc)
import Glibc
extension UnsafeMutableRawBufferPointer: Zeroizable {
    public func zeroize() {
        explicit_bzero(baseAddress!, count)
    }
}
#endif

// MARK: -

public protocol ZeroizableTrivialType: Zeroizable {}

extension ZeroizableTrivialType {
    public mutating func zeroize() {
        assert(_isPOD(Self.self))
        withUnsafeMutableBytes(of: &self) {
            $0.zeroize()
        }
    }
}

extension Bool: ZeroizableTrivialType {}

extension Int:   ZeroizableTrivialType {}
extension Int8:  ZeroizableTrivialType {}
extension Int16: ZeroizableTrivialType {}
extension Int32: ZeroizableTrivialType {}
extension Int64: ZeroizableTrivialType {}

extension UInt:   ZeroizableTrivialType {}
extension UInt8:  ZeroizableTrivialType {}
extension UInt16: ZeroizableTrivialType {}
extension UInt32: ZeroizableTrivialType {}
extension UInt64: ZeroizableTrivialType {}

#if !((os(macOS) || targetEnvironment(macCatalyst)) && arch(x86_64))
@available(macOS 11.0, iOS 14.0, watchOS 14.0, tvOS 7.0, *)
extension Float16: ZeroizableTrivialType {}
#endif
extension Float32: ZeroizableTrivialType {}
extension Float64: ZeroizableTrivialType {}

extension Choice: ZeroizableTrivialType {}

#endif
