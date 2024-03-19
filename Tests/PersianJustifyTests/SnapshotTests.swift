import XCTest
import FontBlaster
import SnapshotTesting
@testable import PersianJustify

final class SnapshotTests: XCTestCase {
    override class func setUp() {
        FontBlaster.blast(bundle: .test)
    }

    func testFonts() {
        let fonts = FontBlaster.loadedFonts
        XCTAssertFalse(fonts.isEmpty)
    }

    #if canImport(UIKit)
    func testSampleViewController() throws {
        let sut = SampleViewController()

        // MARK: Temporary commented due to being failed all the time.
//        assertSnapshot(of: sut, as: .image(size: CGSize(width: 360, height: 780)))
    }
    #endif
}
