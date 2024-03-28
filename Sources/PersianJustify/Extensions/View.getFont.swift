import Foundation

internal extension View {
    func getFont() -> Font? {
        let key = "font"
        guard responds(to: Selector(key)) else { return nil }
        return value(forKey: key) as? Font
    }
}
