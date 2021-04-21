import ConstantTime
import XCTest

fileprivate typealias UIntExhaustive = UInt8

final class ConstantTimeEquatableTests: XCTestCase {
    func testEqualToChoice() {
        XCTAssertEqual(Bool(Choice.true == .true), true)
        XCTAssertEqual(Bool(Choice.true == .false), false)
        XCTAssertEqual(Bool(Choice.false == .true), false)
        XCTAssertEqual(Bool(Choice.false == .false), true)
    }
    
    func testEqualToUIntExhaustive() {
        for lhs in 0...UIntExhaustive.max {
            for rhs in 0...UIntExhaustive.max {
                XCTAssertEqual(Bool(Choice(lhs == rhs)), lhs == rhs)
            }
        }
    }
    
    func testNotEqualToUIntExhaustive() {
        for lhs in 0...UIntExhaustive.max {
            for rhs in 0...UIntExhaustive.max {
                XCTAssertEqual(Bool(Choice(lhs != rhs)), lhs != rhs)
            }
        }
    }
}
