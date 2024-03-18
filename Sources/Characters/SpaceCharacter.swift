import Foundation

/// Wrapper around a character which is used to append a space.
struct SpaceCharacter {
    fileprivate static let _character: Character = " "

    static var stringRepresentation: String {
        String(Self._character)
    }

    static var attributedStringRepresentation: NSAttributedString {
        NSAttributedString(string: stringRepresentation)
    }

    static func + (lhs: String, rhs: SpaceCharacter) -> String {
        lhs + stringRepresentation
    }
}

extension NSMutableAttributedString {
    func appendSpaceCharacter() {
        append(SpaceCharacter.attributedStringRepresentation)
    }
}

extension String.SubSequence {
    func splitWithSpaceSeparator() -> [Substring] {
        split(separator: SpaceCharacter._character)
    }
}
