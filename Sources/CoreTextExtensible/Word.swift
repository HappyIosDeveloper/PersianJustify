import Foundation
import func CoreText.CTLineCreateWithAttributedString
import func CoreText.CTLineGetTypographicBounds

/// Character that should not be extended in any circumstances in `Farsi`.
private let forbiddenExtendableCharacters = ["ا", "د", "ذ", "ر", "ز", "و", "آ", "ژ"]

/// Wrapper around a word.
struct Word {
    fileprivate let _word: Substring

    init(_ word: Substring) {
        self._word = word
    }

    init(_ word: String) {
        self._word = Substring(word)
    }

    var stringRepresentation: String {
        String(_word)
    }

    /// Flag that determines if a word can support extending.
    /// It's common in `Farsi` for a word to be extended in an arbitrary font.
    var canSupportExtender: Bool {
        let count = _word.count

        let isWordEmpty = !_word.lazy.dropFirst().isEmpty
        guard isWordEmpty else {
            return false
        }

        let characters = Array(_word)

        // @Sajad double check where condition
        for i in stride(from: count-1, to: 0, by: -1) where (i > 0) && i < count {
            let char = characters[i]
            let rightChar = characters[i-1]

            let isNotForbiddenCharacter = !forbiddenExtendableCharacters.contains(String(rightChar))
            let isNextCharArabic = rightChar.isArabic
            let isCharArabic = char.isArabic

            if isNotForbiddenCharacter && isNextCharArabic && isCharArabic {
                return true
            }
        }

        return false
    }

    /// Calculate word width based on font.
    func getWordWidth(font: Font, isRequiredSpace: Bool = true) -> CGFloat {
        let wordStringRepresentation = stringRepresentation
        let text = isRequiredSpace ? (wordStringRepresentation + SpaceCharacter()) : wordStringRepresentation

        let attributedString = NSAttributedString(string: text, attributes: [.font: font])
        
        let line = CTLineCreateWithAttributedString(attributedString)
        var ascent: CGFloat = 0
        var descent: CGFloat = 0
        var leading: CGFloat = 0

        let width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading)
        return CGFloat(width)
    }
}

extension String.Element {
    fileprivate var isArabic: Bool {
        let evaluator = ArabicCharacterEvaluator()
        return evaluator.evaluate(with: self)
    }
}

extension [Word] {
    /// Re-create a line from words.
    func createLineFromWords() -> Line {
        let joinedWords = map(\._word)
            .joined(separator: SpaceCharacter.stringRepresentation)

        return Line(joinedWords)
    }
}
