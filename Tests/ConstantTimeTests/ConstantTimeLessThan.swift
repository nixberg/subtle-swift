import ConstantTime
import XCTest

fileprivate typealias UIntExhaustive = UInt8

final class ConstantTimeLessThanTests: XCTestCase {
    func testEqualToExhaustive() {
        for lhs in 0...UIntExhaustive.max {
            for rhs in 0...UIntExhaustive.max {
                XCTAssertEqual(Bool(Choice(lhs < rhs)), lhs < rhs)
            }
        }
    }
    
    func testLessThanOrEqualToExhaustive() {
        for lhs in 0...UIntExhaustive.max {
            for rhs in 0...UIntExhaustive.max {
                XCTAssertEqual(Bool(Choice(lhs <= rhs)), lhs <= rhs)
            }
        }
    }
}
