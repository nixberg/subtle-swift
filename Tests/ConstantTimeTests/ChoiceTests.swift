@testable import ConstantTime
import XCTest

final class ChoiceTests: XCTestCase {
    func testLogicalNOT() {
        XCTAssertEqual(!.true, .false)
        XCTAssertEqual(!.false, .true)
    }
    
    func testLogicalAND() {
        XCTAssertEqual(.true  && .true,  .true )
        XCTAssertEqual(.true  && .false, .false)
        XCTAssertEqual(.false && .true,  .false)
        XCTAssertEqual(.false && .false, .false)
        
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
        XCTAssertEqual(.true  || .true,  .true )
        XCTAssertEqual(.true  || .false, .true )
        XCTAssertEqual(.false || .true,  .true )
        XCTAssertEqual(.false || .false, .false)
        
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
