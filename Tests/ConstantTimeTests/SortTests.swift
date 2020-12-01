import XCTest
import ConstantTime

fileprivate typealias UIntX = UInt8

final class SortTests: XCTestCase {
    func testSort() {
        for count in 0..<256 {
            var rng = SystemRandomNumberGenerator()
            let array: [UIntX] = (0..<count).map { _ in rng.next() }
            XCTAssertEqual(array.sortedInConstantTime(), array.sorted())
        }
    }
}

fileprivate extension Array where Element: FixedWidthInteger & UnsignedInteger {
    func sortedInConstantTime() -> Self {
        var copy = Self(self)
        copy.sortInConstantTime()
        return copy
    }
}
