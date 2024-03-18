import Foundation

/// Wrapper around a character which is used to append a space.
struct SpaceCharacter {
    /*private*/ static let character: Character = " "

    static var stringRepresentation: String {
        String(Self.character)
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
