import Foundation

/// Wrapper around a character which is used to add a small spacer between characters in `Farsi`.
struct MiniSpaceCharacter {
    private static let _character: Character = "‌"

    static var stringRepresentation: String {
        String(Self._character)
    }

    static func + (lhs: MiniSpaceCharacter, rhs: MiniSpaceCharacter) -> String {
        stringRepresentation + stringRepresentation
    }

    static func + (lhs: String, rhs: MiniSpaceCharacter) -> String {
        lhs + stringRepresentation
    }
}
