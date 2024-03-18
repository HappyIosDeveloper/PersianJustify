import Foundation

/// Wrapper around a character which is used to append a new line.
struct NewLine {
    /*private*/ static let _character: Character = "\n"

    static var stringRepresentation: String {
        String(Self._character)
    }

    static var attributedStringRepresentation: NSAttributedString {
        NSAttributedString(string: stringRepresentation)
    }

    static func + (lhs: NewLine, rhs: NewLine) -> String {
        stringRepresentation + stringRepresentation
    }

    static func + (lhs: String, rhs: NewLine) -> String {
        lhs + stringRepresentation
    }
}

extension String {
    func replacingOccurrences(of target: String, with replacement: NewLine) -> String {
        replacingOccurrences(of: target, with: NewLine.stringRepresentation)
    }
}
