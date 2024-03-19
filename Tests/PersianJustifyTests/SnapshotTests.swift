import XCTest
import FontBlaster
@testable import PersianJustify

#if canImport(UIKit)
final class SnapshotTests: XCTestCase {
    override class func setUp() {
        FontBlaster.blast(bundle: Bundle(for: SnapshotTests.self))
}
#endif
