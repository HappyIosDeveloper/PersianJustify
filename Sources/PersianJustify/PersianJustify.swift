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

extension String {
    /// Method that will layouts string in a `Farsi` calligraphy friendly way.
    /// - Warning: This is a computed heavy operation.
    public func toPJString(fittingWidth proposedWidth: CGFloat, font: Font) -> NSAttributedString {
        guard !isEmpty else {
            return NSAttributedString()
        }

        let lines = splitStringToLines()

        return justify(lines, in: proposedWidth, with: font)
    }

    private func splitStringToLines() -> [Line] {
        replaceDoubleEmptyLines()
            .splitWithLineSeparator()
            .map { Line($0) }
    }

    private func replaceDoubleEmptyLines() -> String {
        let doubleNextLine = LineBreakCharacter() + LineBreakCharacter()

        // Replacing double empty lines with one empty line
        return replacingOccurrences(
            of: doubleNextLine,
            with: LineBreakCharacter()
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
                        proposedWidth: proposedWidth,
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
                final.append(LineBreakCharacter.attributedStringRepresentation)
            }
        }

        return final
    }

    private func justifyLine(
        from words: [Word],
        in proposedWidth: CGFloat,
        with font: Font,
        isLastLineInParagraph: Bool
    ) -> NSMutableAttributedString {
        words
            .createLineFromWords()
            .justify(
                in: proposedWidth,
                isLastLineInParagraph: isLastLineInParagraph,
                font: font
            )
    }
}
public enum PersianJustifyFailure: LocalizedError {
    /// Failure to get font from the given view.
    case getFont(View)

    /// Failure to get text from the given view.
    case getText(View)

    public var errorDescription: String? {
        switch self {
            case let .getFont(view):
                return "Failure to get font from \(view)"

            case let .getText(view):
                return "Failure to get text from the \(view)"
        }
    }
}
