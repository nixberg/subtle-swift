@testable import ConstantTime
import XCTest

fileprivate typealias UIntX = UInt8

final class ChoiceTests: XCTestCase {
    func testLogicalNOT() {
        XCTAssertEqual(Bool(!Choice.true), false)
        XCTAssertEqual(Bool(!Choice.false), true)
    }
    
    func testLogicalAND() {
        XCTAssertEqual(Bool(Choice.true  && .true ), true)
        XCTAssertEqual(Bool(Choice.true  && .false), false)
        XCTAssertEqual(Bool(Choice.false && .true ), false)
        XCTAssertEqual(Bool(Choice.false && .false), false)
    }
    
    func testLogicalOR() {
        XCTAssertEqual(Bool(Choice.true  || .true ), true)
        XCTAssertEqual(Bool(Choice.true  || .false), true)
        XCTAssertEqual(Bool(Choice.false || .true ), true)
        XCTAssertEqual(Bool(Choice.false || .false), false)
    }
    
    func testMaskFrom() {
        XCTAssertEqual(UInt(maskFrom:   .true ), .max)
        XCTAssertEqual(UInt(maskFrom:   .false), .min)
        
        XCTAssertEqual(UInt8(maskFrom:  .true ), .max)
        XCTAssertEqual(UInt8(maskFrom:  .false), .min)
        
        XCTAssertEqual(UInt16(maskFrom: .true ), .max)
        XCTAssertEqual(UInt16(maskFrom: .false), .min)
        
        XCTAssertEqual(UInt32(maskFrom: .true ), .max)
        XCTAssertEqual(UInt32(maskFrom: .false), .min)
        
        XCTAssertEqual(UInt64(maskFrom: .true ), .max)
        XCTAssertEqual(UInt64(maskFrom: .false), .min)
    }
}
