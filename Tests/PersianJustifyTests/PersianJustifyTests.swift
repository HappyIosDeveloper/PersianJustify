import XCTest
@testable import PersianJustify

#if canImport(UIKit)
final class PersianJustifyTests: XCTestCase {

    func testUILabelGetFont() {
        let sut = UILabel()
        let expFont = UIFont.systemFont(ofSize: 100)
        sut.font = expFont

        XCTAssertEqual(sut.font, expFont)
        XCTAssertEqual(sut.getFont(), expFont)
        XCTAssertEqual(sut.getFont(), sut.font)
    }

    func testUITextFieldGetFont() {
        let sut = UITextField()
        let expFont = UIFont.systemFont(ofSize: 100)
        sut.font = expFont

        XCTAssertEqual(sut.font, expFont)
        XCTAssertEqual(sut.getFont(), expFont)
        XCTAssertEqual(sut.getFont(), sut.font)
    }

    func testUITextViewGetFont() {
        let sut = UITextView()
        let expFont = UIFont.systemFont(ofSize: 100)
        sut.font = expFont

        XCTAssertEqual(sut.font, expFont)
        XCTAssertEqual(sut.getFont(), expFont)
        XCTAssertEqual(sut.getFont(), sut.font)
    }

    func testUIViewGetFont() {
        let sut = UIView()
        XCTAssertNil(sut.getFont())
    }
}
#endif

#if canImport(AppKit)
final class PersianJustifyTests: XCTestCase {

    // There is no such a thing as `NSLabel` in the `AppKit`

    func testNSTextFieldGetFont() {
        let sut = NSTextField()
        let expFont = NSFont.systemFont(ofSize: 100)
        sut.font = expFont

        XCTAssertEqual(sut.font, expFont)
        XCTAssertEqual(sut.getFont(), expFont)
        XCTAssertEqual(sut.getFont(), sut.font)
    }

    func testUITextViewGetFont() {
        let sut = NSTextView()
        let expFont = NSFont.systemFont(ofSize: 100)
        sut.font = expFont

        XCTAssertEqual(sut.font, expFont)
        XCTAssertEqual(sut.getFont(), expFont)
        XCTAssertEqual(sut.getFont(), sut.font)
    }
}
#endif
