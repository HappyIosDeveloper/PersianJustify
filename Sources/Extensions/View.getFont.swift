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
    func getFont() -> Font? { 
        let key = "font"
        guard responds(to: Selector(key)) else { return nil }
        return value(forKey: key) as? Font
    }
}
