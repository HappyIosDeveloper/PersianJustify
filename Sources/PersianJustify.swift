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

            // To avoid add extra next line at the end of text
            if index < lines.count-1 {
                final.append(NewLine.attributedStringRepresentation)
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

