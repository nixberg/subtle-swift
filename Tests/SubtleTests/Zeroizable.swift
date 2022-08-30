import Subtle
import XCTest

final class ZeroizableTests: XCTestCase {
    func testZeroizable() {
        var array = [1, 2, 3]
        array.zeroize()
        XCTAssert(array.elementsEqual(repeatElement(0, count: array.count)))
    }
}
