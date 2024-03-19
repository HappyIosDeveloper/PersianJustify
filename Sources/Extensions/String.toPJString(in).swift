import Foundation

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
