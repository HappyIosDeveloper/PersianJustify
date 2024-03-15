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
    
    func testMainFunctionIsGettingOutput() {
        let text1 = ""
        let text2 = "blah blah"
        let text3 = "السلام اللعیکم\nو رحمت الله و برکاتو"
        
        let sut = UILabel()
        sut.attributedText = text1.toPJString(in: sut)
        XCTAssertEqual(sut.attributedText?.string.count, text1.count)
        
        sut.attributedText = text2.toPJString(in: sut)
        XCTAssertEqual(sut.attributedText?.string.count, text2.count)
        
        sut.attributedText = text3.toPJString(in: sut)
        XCTAssertEqual(sut.attributedText?.string.count, text3.count)
    }
}
#endif
