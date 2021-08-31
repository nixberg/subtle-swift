import Subtle
import XCTest

fileprivate typealias UIntExhaustive = UInt8

final class ConstantTimeLessThanTests: XCTestCase {
    func testEqualToUIntExhaustive() {
        for lhs in 0...UIntExhaustive.max {
            for rhs in 0...UIntExhaustive.max {
                XCTAssertEqual(Bool(Choice(lhs < rhs)), lhs < rhs)
            }
        }
    }
    
    func testLessThanOrEqualToUIntExhaustive() {
        for lhs in 0...UIntExhaustive.max {
            for rhs in 0...UIntExhaustive.max {
                XCTAssertEqual(Bool(Choice(lhs <= rhs)), lhs <= rhs)
            }
        }
    }
}
