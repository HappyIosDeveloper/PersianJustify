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
        let final = NSMutableAttributedString(string: "")
        let doubleNextLine = nextLineCharacter.description + nextLineCharacter.description
        let allLines = replacingOccurrences(of:doubleNextLine, with: nextLineCharacter.description).getWords(separator: nextLineCharacter)
        let parentWidth = getTotalWidth(in: view)
        for i in 0..<allLines.count {
            let words = allLines[i].split(separator: spaceCharacter).compactMap({$0.description})
            var currentLineWords: [String] = []
            for i in 0..<words.count {
                if currentLineWords.hasRoomForNextWord(nextWord: words[i], parentWidth: parentWidth, font: font) || currentLineWords.isEmpty {
                    currentLineWords.append(words[i])
                } else { // MARK: line is filled and is ready to justify
                    let justifiedLine = currentLineWords.joinWithSpace().getJustifiedLine(in: parentWidth, isLastLineInParagraph: false, font: font)
                    justifiedLine.append(attributedSpace)
                    final.append(justifiedLine)
                    currentLineWords = [words[i]]
                }
            }
            if !currentLineWords.isEmpty {
                final.append(currentLineWords.joinWithSpace().getJustifiedLine(in: parentWidth, isLastLineInParagraph: true, font: font))
            }
            if i < allLines.count-1 { // MARK: To void add extra next line at the end of text
                final.append(attributedNextLine)
            }
        }
        return final
    }
}

// MARK: - Private Functions
private extension String {
    
    func getJustifiedLine(in parentWidth: CGFloat, isLastLineInParagraph: Bool, font: Font) -> NSMutableAttributedString {
        let words = getWords(separator: spaceCharacter)
        let totalWordsWidth = words.compactMap({$0.getWordWidth(font: font)}).reduce(0, +)
        let emptySpace = parentWidth - totalWordsWidth
        let singleExtenderWidth = extenderCharacter.description.getWordWidth(font: font, isRequiredSpace: false)
        let requiredExtender = Swift.max((emptySpace / singleExtenderWidth), 0)
        let supportedExtenderWords = words.filter({$0.isSupportExtender()})
        print("words: ", self)
        print("parent width: \(parentWidth)")
        print("totalWordsWidth \(totalWordsWidth)")
        print("emptySpace: \(emptySpace)")
        if isLastLineInParagraph { // MARK: May not required justify.
            return .init(attributedString: NSAttributedString(string: self))
        } else {
            let isManyExtendersRequired = CGFloat(supportedExtenderWords.count) < requiredExtender
            if isManyExtendersRequired {
                print("many extenders required")
                let requiredExtend = emptySpace / CGFloat(supportedExtenderWords.count)
                return getExtendedWords(words: supportedExtenderWords, requiredExtend: requiredExtend * 0.2, font: font)
            } else if requiredExtender > 0 && supportedExtenderWords.count > 0 {
                print("little extenders required")
                return getExtendedWords(words: supportedExtenderWords, requiredExtend: max(requiredExtender * 0.1, 0), font: font)
            } else {
                print("no extender added")
                return NSMutableAttributedString(attributedString: NSAttributedString(string: self))
            }
        }
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

