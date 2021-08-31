import Subtle
import XCTest

fileprivate typealias UIntExhaustive = UInt8

final class ConditionallyNegatableTests: XCTestCase {
    func testNegatedUIntExhaustive() {
        for value in 0...UIntExhaustive.max {
            XCTAssertEqual(value.negated(if: .true ), 0 &- value)
            XCTAssertEqual(value.negated(if: .false), value)
        }
    }
    
    func testNegateUIntExhaustive() {
        for value in 0...UIntExhaustive.max {
            var a = value
            a.negate(if: .true)
            XCTAssertEqual(a, 0 &- value)
            
            var b = value
            b.negate(if: .false)
            XCTAssertEqual(b, value)
        }
    }
}
