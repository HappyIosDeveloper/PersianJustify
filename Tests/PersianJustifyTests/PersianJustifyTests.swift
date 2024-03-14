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
}
#endif
