import Foundation

extension Bundle {
    private final class BundleFinder { }
    static var test: Bundle { Bundle(for: BundleFinder.self) }
}
