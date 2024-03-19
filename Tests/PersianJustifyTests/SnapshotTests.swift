import XCTest
import FontBlaster
import SnapshotTesting
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

    func testSampleViewController() throws {
        let sut = SampleViewController()

        assertSnapshot(of: sut, as: .image(size: CGSize(width: 360, height: 780)))
    }
}
#endif
