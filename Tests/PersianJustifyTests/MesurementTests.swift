import XCTest

#if canImport(UIKit)
final class MeasurementTests: XCTestCase {
    func testPerformance() throws {
        self.measure(metrics: [XCTCPUMetric(), XCTMemoryMetric()]) {
            let text1 = ""
            let text2 = "blah blah"
            let text3 = "السلام اللعیکم\nو رحمت الله و برکاتو"

            let sut = UILabel()
            sut.attributedText = text1.toPJString(in: sut)

            sut.attributedText = text2.toPJString(in: sut)

            sut.attributedText = text3.toPJString(in: sut)
        }
    }
}
#endif

#if canImport(AppKit)
final class MeasurementTests: XCTestCase {
    func testPerformance() throws {
        self.measure(metrics: [XCTCPUMetric(), XCTMemoryMetric()]) {
            let text1 = ""
            let text2 = "blah blah"
            let text3 = "السلام اللعیکم\nو رحمت الله و برکاتو"

            let sut = NSTextView()
            sut.textStorage?.append(text1.toPJString(in: sut))

            sut.textStorage?.append(text2.toPJString(in: sut))

            sut.textStorage?.append(text3.toPJString(in: sut))
        }
    }
}
#endif
