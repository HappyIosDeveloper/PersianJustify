import XCTest
import FontBlaster
import SnapshotTesting
@testable import PersianJustify

#if canImport(UIKit)
final class UIKitSnapshotTests: XCTestCase {
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

    func testLongMultilineTextOnUILabel() throws {
        let width: CGFloat = 360
        for fontName in FontBlaster.loadedFonts {
            let font = try XCTUnwrap(Font(name: fontName, size: 17))
            let justifiedText = shortDemoText.toPJString(fittingWidth: width, font: font)
            let sut = UILabel()
            sut.attributedText = justifiedText
            sut.numberOfLines = 0
            sut.textColor = .black
            assertSnapshot(
                of: sut,
                as: .image(size: CGSize(width: width, height: 780)),
                named: "Font:\(fontName)"
            )
        }
    }
}
#endif
