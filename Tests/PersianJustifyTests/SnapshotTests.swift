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
}

    #if canImport(UIKit)
    func testSampleViewController() throws {
        let sut = SampleViewController()

        assertSnapshot(of: sut, as: .image(size: CGSize(width: 360, height: 780)))
    }
    #endif
}

#if canImport(AppKit)
extension SnapshotTests {
    func testLongMultilineTextOnNSTextField() throws {
        let width: CGFloat = 360
        for fontName in FontBlaster.loadedFonts {
            let font = try XCTUnwrap(Font(name: fontName, size: 17))
            let justifiedText = longDemoText.toPJString(fittingWidth: width, font: font)
            let sut = NSTextField(labelWithAttributedString: justifiedText)
            sut.textColor = .black

            assertSnapshot(of: sut, as: .image(size: CGSize(width: width, height: 780)))
        }
    }
}
#endif
