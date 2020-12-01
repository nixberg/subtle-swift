import XCTest
import ConstantTime

fileprivate typealias UIntX = UInt8

final class ChoiceTests: XCTestCase {
    func testLogicalNOT() {
        XCTAssertEqual(Bool(!Choice.true), false)
        XCTAssertEqual(Bool(!Choice.false), true)
    }
    
    func testLogicalAND() {
        XCTAssertEqual(Bool(Choice.true  && .true),  true)
        XCTAssertEqual(Bool(Choice.true  && .false), false)
        XCTAssertEqual(Bool(Choice.false && .true),  false)
        XCTAssertEqual(Bool(Choice.false && .false), false)
    }
    
    func testLogicalOR() {
        XCTAssertEqual(Bool(Choice.true  || .true),  true)
        XCTAssertEqual(Bool(Choice.true  || .false), true)
        XCTAssertEqual(Bool(Choice.false || .true),  true)
        XCTAssertEqual(Bool(Choice.false || .false), false)
    }
    
    func testMask() {
        XCTAssertEqual(UInt8(maskFrom: .true),  0xff)
        XCTAssertEqual(UInt8(maskFrom: .false), 0x00)
        
        XCTAssertEqual(UInt16(maskFrom: .true),  0xffff)
        XCTAssertEqual(UInt16(maskFrom: .false), 0x0000)
        
        XCTAssertEqual(UInt32(maskFrom: .true),  0xffff_ffff)
        XCTAssertEqual(UInt32(maskFrom: .false), 0x0000_0000)
        
        XCTAssertEqual(UInt64(maskFrom: .true),  0xffff_ffff_ffff_ffff)
        XCTAssertEqual(UInt64(maskFrom: .false), 0x0000_0000_0000_0000)
    }
    
    func testIsZero() {
        XCTAssertEqual(Bool((0 as UIntX).isZero), true)
        for byte in 1...UIntX.max {
            XCTAssertEqual(Bool(byte.isZero), false)
        }
    }
    
    func testEqualTo() {
        for lhs in 0...UIntX.max {
            for rhs in 0...UIntX.max {
                XCTAssertEqual(Bool(Choice(lhs == rhs)), lhs == rhs)
            }
        }
    }
    
    func testNotEqualTo() {
        for lhs in 0...UIntX.max {
            for rhs in 0...UIntX.max {
                XCTAssertEqual(Bool(Choice(lhs != rhs)), lhs != rhs)
            }
        }
    }
    
    func testLessThan() {
        for lhs in 0...UIntX.max {
            for rhs in 0...UIntX.max {
                XCTAssertEqual(Bool(Choice(lhs < rhs)), lhs < rhs)
            }
        }
    }
    
    func testLessThanOrEqualTo() {
        for lhs in 0...UIntX.max {
            for rhs in 0...UIntX.max {
                XCTAssertEqual(Bool(Choice(lhs <= rhs)), lhs <= rhs)
            }
        }
    }
    
    func testGreaterThan() {
        for lhs in 0...UIntX.max {
            for rhs in 0...UIntX.max {
                XCTAssertEqual(Bool(Choice(lhs > rhs)), lhs > rhs)
            }
        }
    }
    
    func testGreaterThanOrEqualTo() {
        for lhs in 0...UIntX.max {
            for rhs in 0...UIntX.max {
                XCTAssertEqual(Bool(Choice(lhs >= rhs)), lhs >= rhs)
            }
        }
    }
}
