import Foundation

#if canImport(UIKit)
import class UIKit.NSMutableParagraphStyle
import enum UIKit.NSTextAlignment
#elseif canImport(AppKit)
import class AppKit.NSMutableParagraphStyle
import enum AppKit.NSTextAlignment
#endif

/// Wrapper around a line.
/// Object will extend line capabilities and encapsulate logics related to justifying a line.
struct Line {
    private let _line: String.SubSequence

    init(_ line: String.SubSequence) {
        self._line = line
    }

    init(_ line: String) {
        self._line = String.SubSequence(line)
    }

    var stringRepresentation: String {
        String(_line)
    }

    /// Get every word in a line.
    func getWords() -> [Word] {
        _line.splitWithSpaceSeparator()
            .map { Word($0) }
    }

    /// Re-aligns a line based on proposed width and given font.
    func justify(
        in proposedWidth: CGFloat,
        isLastLineInParagraph: Bool,
        font: Font
    ) -> NSMutableAttributedString {
        let words = getWords()

        lazy var emptySpace: CGFloat = {
            let totalWordsWidth = words.getRequiredWidth(with: font)

            return proposedWidth - totalWordsWidth
        }()

        lazy var requiredExtender: CGFloat = {
            let singleExtenderWidth = ExtenderCharacter
                .wordRepresentation
                .getWordWidth(font: font, isRequiredSpace: false)

            let extractedExpr = emptySpace / singleExtenderWidth
            return Swift.max(extractedExpr, 0)
        }()

        let supportedExtenderWords = words.filter { $0.canSupportExtender }

        if isLastLineInParagraph {
            // May not required justify.
            return NSMutableAttributedString(string: stringRepresentation)
        } else {
            lazy var isManyExtendersRequired = CGFloat(supportedExtenderWords.count) < requiredExtender

            let requiredExtend: CGFloat

            if isManyExtendersRequired {
                requiredExtend = emptySpace / CGFloat(supportedExtenderWords.count)
            } else if requiredExtender > 0 && supportedExtenderWords.count > 0 {
                requiredExtend = max(requiredExtender * 0.1, 0)
            } else {
                return NSMutableAttributedString(string: stringRepresentation)
            }

            return getExtendedWords(
                words: supportedExtenderWords,
                requiredExtend: requiredExtend * 0.2,
                font: font
            )
        }
    }

    private func getExtendedWords(
        words: [Word],
        requiredExtend: CGFloat,
        font: Font
    ) -> NSMutableAttributedString {
        let style: NSMutableParagraphStyle = {
            let style = NSMutableParagraphStyle()
            style.alignment = NSTextAlignment.justified
            style.baseWritingDirection = .rightToLeft
            return style
        }()

        let totalRange = NSRange(location: 0, length: _line.utf16.count)

        let attributedText = NSMutableAttributedString(string: stringRepresentation)
        attributedText.setAttributes([NSAttributedString.Key.font: font], range: totalRange)

        for word in words {
            let range = getRange(of: word)
            attributedText.addAttribute(NSAttributedString.Key.kern, value: requiredExtend, range: range)
            attributedText.addAttributes([NSAttributedString.Key.paragraphStyle: style], range: range)
        }

        return attributedText
    }

    private func getRange(of word: Word) -> NSRange {
        (_line as NSString).range(of: word.stringRepresentation, options: .widthInsensitive)
    }
}

extension [Word] {
    /// Method that will determine if a given word can fit inside the line based on proposed width.
    func hasRoomForNextWord(nextWord: Word, proposedWidth: CGFloat, font: Font) -> Bool {
        let requiredWidth = nextWord.getWordWidth(font: font)
        let currentWidth = getRequiredWidth(with: font)
        return (currentWidth + requiredWidth) <= proposedWidth
    }

    /// Method that will calculate required width for words.
    fileprivate func getRequiredWidth(with font: Font) -> CGFloat {
        map { $0.getWordWidth(font: font) }
            .reduce(0, +)
    }
}
