import XCTest
import FontBlaster
@testable import PersianJustify

#if canImport(UIKit)
final class SnapshotTests: XCTestCase {
    override class func setUp() {
        FontBlaster.blast(bundle: .test)
    }

    func testFonts() {
        let fonts = FontBlaster.loadedFonts
        XCTAssertFalse(fonts.isEmpty)
    }
}
#endif
