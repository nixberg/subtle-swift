@testable import ConstantTime
import XCTest

final class ChoiceTests: XCTestCase {
    func testLogicalNOT() {
        XCTAssertEqual(!Choice.true, .false)
        XCTAssertEqual(!Choice.false, .true)
    }
    
    func testLogicalAND() {
        XCTAssertEqual(Choice.true  && .true,  .true )
        XCTAssertEqual(Choice.true  && .false, .false)
        XCTAssertEqual(Choice.false && .true,  .false)
        XCTAssertEqual(Choice.false && .false, .false)
        
        var a: Choice = .true
        a &&= .true
        XCTAssertEqual(a, .true)
        
        var b: Choice = .true
        b &&= .false
        XCTAssertEqual(b, .false)
        
        var c: Choice = .false
        c &&= .true
        XCTAssertEqual(c, .false)
        
        var d: Choice = .false
        d &&= .false
        XCTAssertEqual(d, .false)
    }
    
    func testLogicalOR() {
        XCTAssertEqual(Choice.true  || .true,  .true )
        XCTAssertEqual(Choice.true  || .false, .true )
        XCTAssertEqual(Choice.false || .true,  .true )
        XCTAssertEqual(Choice.false || .false, .false)
        
        var a: Choice = .true
        a ||= .true
        XCTAssertEqual(a, .true)
        
        var b: Choice = .true
        b ||= .false
        XCTAssertEqual(b, .true)
        
        var c: Choice = .false
        c ||= .true
        XCTAssertEqual(c, .true)
        
        var d: Choice = .false
        d ||= .false
        XCTAssertEqual(d, .false)
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

extension Choice: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        Bool(Choice(lhs == rhs))
    }
}
