#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

private let key = "font"

extension View {
    func getFont() -> Font? {
        // Opaque pointer to font in the given view
        let fontSelector = Selector(key)

        // Arguably this defensive check can be omitted,
        // Since if a view has a font property, we can fetch font from 
        guard responds(to: fontSelector) else {
            return nil
        }

        return value(forKey: key) as? Font
    }
}
