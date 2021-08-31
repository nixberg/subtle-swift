import Subtle
import XCTest

final class SortTests: XCTestCase {
    let elementCountRange = 0...128
    
    func testSortUInt() {
        for count in elementCountRange {
            var rng = SystemRandomNumberGenerator()
            let array: [UInt] = (0..<count).map { _ in rng.next() }
            XCTAssertEqual(array.sortedInConstantTime(), array.sorted())
        }
    }
    
    func testSortUInt8() {
        for count in elementCountRange {
            var rng = SystemRandomNumberGenerator()
            let array: [UInt8] = (0..<count).map { _ in rng.next() }
            XCTAssertEqual(array.sortedInConstantTime(), array.sorted())
        }
    }
    
    func testSortUInt16() {
        for count in elementCountRange {
            var rng = SystemRandomNumberGenerator()
            let array: [UInt16] = (0..<count).map { _ in rng.next() }
            XCTAssertEqual(array.sortedInConstantTime(), array.sorted())
        }
    }
    
    func testSortUInt32() {
        for count in elementCountRange {
            var rng = SystemRandomNumberGenerator()
            let array: [UInt32] = (0..<count).map { _ in rng.next() }
            XCTAssertEqual(array.sortedInConstantTime(), array.sorted())
        }
    }
    
    func testSortUInt64() {
        for count in elementCountRange {
            var rng = SystemRandomNumberGenerator()
            let array: [UInt64] = (0..<count).map { _ in rng.next() }
            XCTAssertEqual(array.sortedInConstantTime(), array.sorted())
        }
    }
}
