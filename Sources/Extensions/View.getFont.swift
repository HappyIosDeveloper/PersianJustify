#if canImport(UIKit)
import UIKit

internal extension UIView {

    func getFont() -> UIFont? { value(forKey: "font") as? UIFont }
}
#endif
