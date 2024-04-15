//
//  File.swift
//  
//
//  Created by Ahmadreza on 3/15/24.
//

import XCTest
@testable import PersianJustify

#if canImport(UIKit)
final class MainFunctionalityTests: XCTestCase {
    
    func testPerformance() {
        let sut = UILabel()
        measure {
            sut.attributedText = longDemoText.toPJString(fittingWidth: sut.bounds.width, font: sut.font)
        }
    }
    
    func testMainFunctionIsGettingOutput() {
        let text1 = ""
        let text2 = "blah blah"
        let text3 = "السلام اللعیکم\nو رحمت الله و برکاتو"
        
        let sut = UILabel()
        sut.attributedText = text1.toPJString(fittingWidth: sut.bounds.width, font: sut.font)
        XCTAssertEqual(sut.attributedText?.string.count, text1.count)
        
        sut.attributedText = text2.toPJString(fittingWidth: sut.bounds.width, font: sut.font)
        XCTAssertEqual(sut.attributedText?.string.count, text2.count)
        
        sut.attributedText = text3.toPJString(fittingWidth: sut.bounds.width, font: sut.font)
        XCTAssertEqual(sut.attributedText?.string.count, text3.count)
    }
    
    func testMainFunctionIsGettingExactNextLineCharacter() {
        let noEnter = "a"
        let twoEnters = "a\na"
        let threeEnters = "a\na\na\na"
        
        let sut = UILabel()
        sut.attributedText = noEnter.toPJString(fittingWidth: sut.bounds.width, font: sut.font)
        XCTAssertEqual(sut.attributedText?.string.getNextLineCount(), noEnter.getNextLineCount())
        
        sut.attributedText = twoEnters.toPJString(fittingWidth: sut.bounds.width, font: sut.font)
        XCTAssertEqual(sut.attributedText?.string.getNextLineCount(), twoEnters.getNextLineCount())
        
        sut.attributedText = threeEnters.toPJString(fittingWidth: sut.bounds.width, font: sut.font)
        XCTAssertEqual(sut.attributedText?.string.getNextLineCount(), threeEnters.getNextLineCount())
    }
    
    func testMainFunctionIsGettingExactSpaceCharacter() {
        let noSpace = "a"
        let twoSpaces = "a a"
        let threeSpaces = "a a a a"
        
        let sut = UILabel()
        sut.attributedText = noSpace.toPJString(fittingWidth: sut.bounds.width, font: sut.font)
        XCTAssertEqual(sut.attributedText?.string.getSpaceCount(), noSpace.getSpaceCount())
        
        sut.attributedText = twoSpaces.toPJString(fittingWidth: sut.bounds.width, font: sut.font)
        XCTAssertEqual(sut.attributedText?.string.getSpaceCount(), twoSpaces.getSpaceCount())
        
        sut.attributedText = threeSpaces.toPJString(fittingWidth: sut.bounds.width, font: sut.font)
        XCTAssertEqual(sut.attributedText?.string.getSpaceCount(), threeSpaces.getSpaceCount())
    }
}
#endif

private extension String {
    
    func getNextLineCount()-> Int {
        return filter({$0 == "\n"}).count
    }
    
    func getSpaceCount()-> Int {
        return filter({$0 == " "}).count
    }
}
