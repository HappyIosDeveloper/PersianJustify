#if canImport(UIKit)
import UIKit

internal extension UIView {

    func getFont() -> UIFont? { value(forKey: "font") as? UIFont }
}
#endif

#if canImport(AppKit)
import AppKit

internal extension NSView {

    func getFont() -> NSFont? { value(forKey: "font") as? NSFont }
}
#endif
