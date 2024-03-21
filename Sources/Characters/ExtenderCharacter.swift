import Foundation

/// Wrapper around a character which is used to extend some characters in `Farsi`.
struct ExtenderCharacter {
    private static let _character: Character = "ـ" // Persian underline

    static var stringRepresentation: String {
        String(Self._character)
    }

    static var wordRepresentation: Word {
        Word(stringRepresentation)
    }
}
