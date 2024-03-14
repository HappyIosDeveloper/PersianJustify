//
//  MainLogics.swift
//  PersianJustify
//
//  Created by Ahmadreza on 3/14/24.
//

import UIKit
import CoreText

// MARK: - Variables
fileprivate let nextLineCharacter: Character = "\n"
fileprivate let spaceCharacter: Character = " "
fileprivate let miniSpaceCharacter: Character = "‌"
fileprivate let extenderCharacter: Character = "ـ" // Persian underline
fileprivate let attributedSpace = NSAttributedString(string: spaceCharacter.description)
fileprivate let attributedNextLine = NSMutableAttributedString(string: nextLineCharacter.description)
fileprivate let forbiddenExtendableCharacters = ["ا", "د", "ذ", "ر", "ز", "و", "آ", "ژ"]

// MARK: - Usage using toPJString function
extension String {
    
    public func toPJString(in view: UIView)-> NSAttributedString {
        //        return self // MARK: Uncomment to see the unjustified text
        if isEmpty { return NSAttributedString(string: self) }
        let font = view.getFont()
        let final = NSMutableAttributedString(string: "")
        let allLines = replacingOccurrences(of: "\n\n", with: nextLineCharacter.description).getWords(separator: nextLineCharacter)
        let parentWidth = getTotalWidth(in: view)
        for line in allLines {
            let words = line.split(separator: spaceCharacter).compactMap({$0.description})
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
            final.append(attributedNextLine)
        }
        return final
    }
}

// MARK: - Private Functions
private extension String {
    
    func getJustifiedLine(in parentWidth: CGFloat, isLastLineInParagraph: Bool, font: UIFont)-> NSMutableAttributedString {
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
    
    func getExtendedWords(words: [String], requiredExtend: CGFloat, font: UIFont)-> NSMutableAttributedString {
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
    
    func getWords(separator: Character)-> [String] {
        return split(separator: separator).compactMap({$0.description})
    }

    func getTotalWidth(in view: UIView)-> CGFloat {
        return view.frame.width
    }
    
    func getWordWidth(font: UIFont, isRequiredSpace: Bool = true)-> CGFloat {
        let text = isRequiredSpace ? (self + spaceCharacter.description) : self
        let attributedString = NSAttributedString(string: text, attributes: [.font: font])
        let line = CTLineCreateWithAttributedString(attributedString)
        var ascent: CGFloat = 0
        var descent: CGFloat = 0
        var leading: CGFloat = 0
        let width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading)
        return CGFloat(width)
    }
    
    func getRange(of word: String)-> NSRange {
        return (self as NSString).range(of: word, options: .widthInsensitive)
    }
    
    func isSupportExtender()-> Bool {
        let array = Array(self)
        if count > 1 {
            for i in stride(from: count-1, to: 0, by: -1) where (i > 0) && i < count {
                let char = array[i].description
                let rightChar = array[i-1].description
                if !forbiddenExtendableCharacters.contains(rightChar) && rightChar.isArabic && char.isArabic {
                    return true
                }
            }
            return false
        } else {
            return false
        }
    }
}

private extension [String] {
    
    func hasRoomForNextWord(nextWord: String, parentWidth: CGFloat, font: UIFont) -> Bool {
        let requiredWidth = nextWord.getWordWidth(font: font)
        let currentWidth = compactMap({$0.getWordWidth(font: font)}).reduce(0, +)
        return (currentWidth + requiredWidth) <= parentWidth
    }
    
    func joinWithSpace()-> String {
        return joined(separator: spaceCharacter.description)
    }
}

// MARK: - UIView Extension
internal extension UIView {

    func getFont() -> UIFont {
        let defaultFont = UIFont()
        var viewFont: UIFont? {
            if let label = self as? UILabel {
                return label.font
            } else if let textView = self as? UITextView {
                return textView.font
            } else if let textField = self as? UITextField {
                return textField.font
            } else {
                return nil
            }
        }

        return viewFont ?? defaultFont
    }
}
