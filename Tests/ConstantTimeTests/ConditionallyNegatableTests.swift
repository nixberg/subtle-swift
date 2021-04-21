@testable import ConstantTime
import XCTest

fileprivate typealias UIntExhaustive = UInt8

final class ConditionallyNegatableTests: XCTestCase {
    func testNegatedExhaustive() {
        for value in 0...UIntExhaustive.max {
            XCTAssertEqual(value.negated(if: .true), 0 &- value)
            XCTAssertEqual(value.negated(if: .false), value)
        }
    }
    
    func testNegateExhaustive() {
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
