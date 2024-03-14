#if canImport(UIKit)
import UIKit
public typealias Font = UIFont
public typealias View = UIView
#endif

#if canImport(AppKit)
import AppKit
public typealias Font = NSFont
public typealias View = NSView
#endif

internal extension View {
    func getFont() -> Font? { 
        let key = "font"
        guard responds(to: Selector(key)) else { return nil }
        return value(forKey: key) as? Font
    }
}
