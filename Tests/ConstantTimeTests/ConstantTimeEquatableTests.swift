import ConstantTime
import XCTest

fileprivate typealias UIntExhaustive = UInt8

final class ConstantTimeEquatableTests: XCTestCase {
    func testEqualToChoice() {
        XCTAssertEqual(.true  == .true,  .true )
        XCTAssertEqual(.true  == .false, .false)
        XCTAssertEqual(.false == .true,  .false)
        XCTAssertEqual(.false == .false, .true )
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
    
    func testEqualSequence() {
        let lhs: Range<UInt8> = 0..<16
        let rhs: Range<UInt8> = 0..<16
        XCTAssertEqual(lhs == rhs, .true )
        XCTAssertEqual(lhs != rhs, .false)
    }
    
    func testNotEqualSequence() {
        let lhs: Range<UInt8> = 0..<16
        let rhs: Range<UInt8> = 1..<17
        XCTAssertEqual(lhs == rhs, .false)
        XCTAssertEqual(lhs != rhs, .true )
    }
    
    func testEqualRandomAccessCollection() {
        let lhs: [UInt8] = Array(0..<16)
        let rhs: [UInt8] = Array(0..<16)
        XCTAssertEqual(lhs == rhs, .true )
        XCTAssertEqual(lhs != rhs, .false)
    }
    
    func testNotEqualRandomAccessCollection() {
        let lhs: [UInt8] = Array(0..<16)
        let rhs: [UInt8] = Array(1..<17)
        XCTAssertEqual(lhs == rhs, .false)
        XCTAssertEqual(lhs != rhs, .true )
    }
}
