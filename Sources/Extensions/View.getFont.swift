#if canImport(UIKit)
import UIKit
typealias Font = UIFont
typealias View = UIView
#endif

#if canImport(AppKit)
import AppKit
typealias Font = NSFont
typealias View = NSView
#endif

internal extension View {
    func getFont() -> Font? { value(forKey: "font") as? Font }
}
