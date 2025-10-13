import UIKit

extension String {

    @available(
        *, deprecated,
        renamed: "toPJString(fittingWidth:font:)",
        message: "This method requires too much information and will not be available from v1.0"
    )
    public func toPJString(in view: View) -> NSAttributedString {
        let defaultFont = Font()
        let font = view.getFont() ?? defaultFont
        let parentWidth = view.frame.width

        return toPJString(fittingWidth: parentWidth, font: font)
    }
}

extension UILabel {
    
    @available(iOS 26.0, *)
    func fixDirectionForiOS26() {
        if let traitOverrides = value(forKey: "traitOverrides") as? NSObject {
            if traitOverrides.responds(to: NSSelectorFromString("setResolvesNaturalAlignmentWithBaseWritingDirection:")) {
                traitOverrides.setValue(true, forKey: "resolvesNaturalAlignmentWithBaseWritingDirection")
            }
        }
    }
}
