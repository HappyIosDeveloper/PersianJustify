import XCTest

#if canImport(UIKit)
final class MeasurementTests: XCTestCase {
    func testPerformance() throws {
        self.measure(metrics: [XCTCPUMetric(), XCTMemoryMetric()]) {
            let texts = [
                "",
                "blah blah",
                "السلام اللعیکم\nو رحمت الله و برکاتو"
            ]

            let sut = UILabel()
            let fittingWidth = sut.frame.width

            texts.forEach { text in
                sut.attributedText = text.toPJString(fittingWidth: fittingWidth)
            }
        }
    }
}
#endif

#if canImport(AppKit)
final class MeasurementTests: XCTestCase {
    func testPerformance() throws {
        self.measure(metrics: [XCTCPUMetric(), XCTMemoryMetric()]) {
            let texts = [
                "",
                "blah blah",
                "السلام اللعیکم\nو رحمت الله و برکاتو"
            ]

            let sut = NSTextView()
            let fittingWidth = sut.frame.width

            texts.forEach { text in
                sut.textStorage?.append(text.toPJString(fittingWidth: fittingWidth, font: sut.font!))
            }
        }
    }
}
#endif
