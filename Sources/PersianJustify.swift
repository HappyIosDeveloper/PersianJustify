//
//  MainLogics.swift
//  PersianJustify
//
//  Created by Ahmadreza on 3/14/24.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Usage using toPJString function
extension String {
    
    public func toPJString(in view: View) -> NSAttributedString {
        let defaultAttributedTest = NSAttributedString(string: self)
        //                return defaultAttributedTest // MARK: Uncomment to see the unjustified text
        if isEmpty { return defaultAttributedTest }
        let defaultFont = Font()
        let font = view.getFont() ?? defaultFont
    private func splitStringToLines() -> [Line] {
        replaceDoubleEmptyLines()
            .split(separator: NewLine._character)
            .map { Line($0) }
    }

    private func replaceDoubleEmptyLines() -> String {
        let doubleNextLine = NewLine() + NewLine()

        // Replacing double empty lines with one empty line
        return replacingOccurrences(
            of: doubleNextLine,
            with: NewLine()
        )
    }

    private func justify(
        _ lines: [Line],
        in proposedWidth: CGFloat,
        with font: Font
    ) -> NSAttributedString {
        let final = NSMutableAttributedString(string: "")

        lines.enumerated().forEach { index, line in
            let words = line.getWords()

            var currentLineWords: [Word] = []

            words.forEach { word in
                let canAddNewWord: Bool = {
                    let lineHasRoomForNextWord = currentLineWords.hasRoomForNextWord(
                        nextWord: word,
                        parentWidth: proposedWidth,
                        font: font
                    )

                    lazy var isLineEmpty = currentLineWords.isEmpty

                    return lineHasRoomForNextWord || isLineEmpty
                }()

                if canAddNewWord {
                    currentLineWords.append(word)
                } 
                // Line is filled and is ready to justify
                else {
                    let justifiedLine = justifyLine(
                        from: currentLineWords,
                        in: proposedWidth,
                        with: font,
                        isLastLineInParagraph: false
                    )

                    // Appending space at the end
                    justifiedLine.appendSpaceCharacter()

                    final.append(justifiedLine)

                    currentLineWords = [word]
                }
            }

            if !currentLineWords.isEmpty {
                let extracted = justifyLine(
                    from: currentLineWords,
                    in: proposedWidth,
                    with: font,
                    isLastLineInParagraph: true
                )

                final.append(extracted)
            }
    
    func getExtendedWords(words: [String], requiredExtend: CGFloat, font: Font) -> NSMutableAttributedString {
        print("------------------------------------------")
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.justified
        style.baseWritingDirection = .rightToLeft
        let totalRange = NSRange(location: 0, length: self.utf16.count)
        let attributedText = NSMutableAttributedString(string: self)
        attributedText.setAttributes([NSAttributedString.Key.font: font], range: totalRange)
        for word in words {
            let range = getRange(of: word)
            attributedText.addAttribute(NSAttributedString.Key.kern, value: requiredExtend, range: range)
            attributedText.addAttributes([NSAttributedString.Key.paragraphStyle: style], range: range)
            print("applying extend | \(requiredExtend) to \(word)")
        }
        print("------------------------------------------")
        return attributedText
    }
    
    var isArabic: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "(?s).*\\p{Arabic}.*")
        return predicate.evaluate(with: self)
    }
    
    func getWords(separator: Character) -> [String] {
        return split(separator: separator).compactMap({$0.description})
    }

    func getTotalWidth(in view: View) -> CGFloat {
        return view.frame.width
    }
    
    func getWordWidth(font: Font, isRequiredSpace: Bool = true) -> CGFloat {
        let text = isRequiredSpace ? (self + spaceCharacter.description) : self
        let attributedString = NSAttributedString(string: text, attributes: [.font: font])
        let line = CTLineCreateWithAttributedString(attributedString)
        var ascent: CGFloat = 0
        var descent: CGFloat = 0
        var leading: CGFloat = 0
        let width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading)
        return CGFloat(width)
    }
    
    func getRange(of word: String) -> NSRange {
        return (self as NSString).range(of: word, options: .widthInsensitive)
    }
    
    func isSupportExtender() -> Bool {
        guard count > 1 else { return false }
        let array = Array(self)
        for i in stride(from: count-1, to: 0, by: -1) where (i > 0) && i < count {
            let char = array[i].description
            let rightChar = array[i-1].description
            if !forbiddenExtendableCharacters.contains(rightChar) && rightChar.isArabic && char.isArabic {
                return true
            }
        }
        return false
    }
}

private extension [String] {
    
    func hasRoomForNextWord(nextWord: String, parentWidth: CGFloat, font: Font) -> Bool {
        let requiredWidth = nextWord.getWordWidth(font: font)
        let currentWidth = compactMap({$0.getWordWidth(font: font)}).reduce(0, +)
        return (currentWidth + requiredWidth) <= parentWidth
    }
    
    func joinWithSpace() -> String {
        return joined(separator: spaceCharacter.description)
    }
}

