@testable import ConstantTime
import XCTest

fileprivate typealias UIntExhaustive = UInt8

final class ConstantTimeReplaceableTests: XCTestCase {
    func testReplacedExhaustive() {
        for lhs in 0...UIntExhaustive.max {
            for rhs in 0...UIntExhaustive.max {
                XCTAssertEqual(lhs.replaced(with: rhs, if: .false), lhs)
                XCTAssertEqual(lhs.replaced(with: rhs, if: .true),  rhs)
            }
        }
    }
    
    func testReplaceExhaustive() {
        for lhs in 0...UIntExhaustive.max {
            for rhs in 0...UIntExhaustive.max {
                var a = lhs
                a.replace(with: rhs, if: .false)
                XCTAssertEqual(a, lhs)
                
                var b = lhs
                b.replace(with: rhs, if: .true)
                XCTAssertEqual(b, rhs)
            }
        }
    }
    
    func testSwappedExhaustive() {
        for lhs in 0...UIntExhaustive.max {
            for rhs in 0...UIntExhaustive.max {
                let (a, b) = lhs.swapped(with: rhs, if: .false)
                XCTAssertEqual(a, lhs)
                XCTAssertEqual(b, rhs)
                
                let (c, d) = lhs.swapped(with: rhs, if: .true)
                XCTAssertEqual(c, rhs)
                XCTAssertEqual(d, lhs)
            }
        }
    }
    
    func testSwapExhaustive() {
        for lhs in 0...UIntExhaustive.max {
            for rhs in 0...UIntExhaustive.max {
                var (a, b) = (lhs, rhs)
                a.swap(with: &b, if: .false)
                XCTAssertEqual(a, lhs)
                XCTAssertEqual(b, rhs)
                
                var (c, d) = (lhs, rhs)
                c.swap(with: &d, if: .true)
                XCTAssertEqual(c, rhs)
                XCTAssertEqual(d, lhs)
            }
        }
    }
}
