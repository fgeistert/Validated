//
//  ValidationFormatter+String_Tests.swift
//  ValidatedTests
//
//  Created by Fabian Geistert on 28.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import XCTest
@testable import Validated

final class ValidationFormatter_String_Tests: XCTestCase {
    
    // MARK: - Trimmed
    
    func testTrimmedNoChange() {
        let formatter1 = ValidationFormatter.trimmed
        let input1 = "ABC"
        let formattedInput1 = formatter1.formatter(input1)
        XCTAssertEqual(formattedInput1, input1)
        
        let formatter2 = ValidationFormatter.trimmed
        let input2 = "1234"
        let formattedInput2 = formatter2.formatter(input2)
        XCTAssertEqual(formattedInput2, input2)
        
        let formatter3 = ValidationFormatter.trimmed
        let input3 = "A B C D"
        let formattedInput3 = formatter3.formatter(input3)
        XCTAssertEqual(formattedInput3, input3)
        
        let formatter4 = ValidationFormatter.trimmed
        let input4 = "👋 👋"
        let formattedInput4 = formatter4.formatter(input4)
        XCTAssertEqual(formattedInput4, input4)
    }
    
    func testTrimmedChange() {
        let formatter1 = ValidationFormatter.trimmed
        let input1 = " ABC "
        let formattedInput1 = formatter1.formatter(input1)
        XCTAssertEqual(formattedInput1, "ABC")
        
        let formatter2 = ValidationFormatter.trimmed
        let input2 = "       1234       "
        let formattedInput2 = formatter2.formatter(input2)
        XCTAssertEqual(formattedInput2, "1234")
        
        let formatter3 = ValidationFormatter.trimmed
        let input3 = "     A B C D     "
        let formattedInput3 = formatter3.formatter(input3)
        XCTAssertEqual(formattedInput3, "A B C D")
        
        let formatter4 = ValidationFormatter.trimmed
        let input4 = "      👋 👋  "
        let formattedInput4 = formatter4.formatter(input4)
        XCTAssertEqual(formattedInput4, "👋 👋")
    }
    
    // MARK: - Trimmed With CharacterSet
    
    func testTrimmedWithCharacterSetNoChange() {
        let formatter1 = ValidationFormatter.trimmed(with: .whitespacesAndNewlines)
        let input1 = "ABC"
        let formattedInput1 = formatter1.formatter(input1)
        XCTAssertEqual(formattedInput1, input1)
        
        let formatter2 = ValidationFormatter.trimmed(with: .whitespacesAndNewlines)
        let input2 = "1234"
        let formattedInput2 = formatter2.formatter(input2)
        XCTAssertEqual(formattedInput2, input2)
        
        let formatter3 = ValidationFormatter.trimmed(with: .whitespacesAndNewlines)
        let input3 = "A B\n C\n D"
        let formattedInput3 = formatter3.formatter(input3)
        XCTAssertEqual(formattedInput3, input3)
        
        let formatter4 = ValidationFormatter.trimmed(with: .whitespacesAndNewlines)
        let input4 = "👋 \n 👋"
        let formattedInput4 = formatter4.formatter(input4)
        XCTAssertEqual(formattedInput4, input4)
    }
    
    func testTrimmedWithCharacterSetChange() {
        let formatter1 = ValidationFormatter.trimmed(with: .whitespacesAndNewlines)
        let input1 = "   \n    ABC   \n    "
        let formattedInput1 = formatter1.formatter(input1)
        XCTAssertEqual(formattedInput1, "ABC")
        
        let formatter2 = ValidationFormatter.trimmed(with: .whitespacesAndNewlines)
        let input2 = "\n\n\n1234\n\n\n"
        let formattedInput2 = formatter2.formatter(input2)
        XCTAssertEqual(formattedInput2, "1234")
        
        let formatter3 = ValidationFormatter.trimmed(with: .whitespacesAndNewlines)
        let input3 = "    A B\n C\n D\n\n   \n\n"
        let formattedInput3 = formatter3.formatter(input3)
        XCTAssertEqual(formattedInput3, "A B\n C\n D")
        
        let formatter4 = ValidationFormatter.trimmed(with: .whitespacesAndNewlines)
        let input4 = "    👋 \n 👋 \n\n\n"
        let formattedInput4 = formatter4.formatter(input4)
        XCTAssertEqual(formattedInput4, "👋 \n 👋")
    }
    
    // MARK: - Uppercased
    
    func testUppercasedNoChange() {
        let formatter1 = ValidationFormatter.uppercased
        let input1 = "ABC"
        let formattedInput1 = formatter1.formatter(input1)
        XCTAssertEqual(formattedInput1, input1)
        
        let formatter2 = ValidationFormatter.uppercased
        let input2 = "1234"
        let formattedInput2 = formatter2.formatter(input2)
        XCTAssertEqual(formattedInput2, input2)
        
        let formatter3 = ValidationFormatter.uppercased
        let input3 = "A B\n C\n D"
        let formattedInput3 = formatter3.formatter(input3)
        XCTAssertEqual(formattedInput3, input3)
        
        let formatter4 = ValidationFormatter.uppercased
        let input4 = "👋 \n 👋"
        let formattedInput4 = formatter4.formatter(input4)
        XCTAssertEqual(formattedInput4, input4)
    }
    
    func testUppercasedChange() {
        let formatter1 = ValidationFormatter.uppercased
        let input1 = "abc"
        let formattedInput1 = formatter1.formatter(input1)
        XCTAssertEqual(formattedInput1, "ABC")
        
        let formatter2 = ValidationFormatter.uppercased
        let input2 = " abc"
        let formattedInput2 = formatter2.formatter(input2)
        XCTAssertEqual(formattedInput2, " ABC")
        
        let formatter3 = ValidationFormatter.uppercased
        let input3 = "a b c"
        let formattedInput3 = formatter3.formatter(input3)
        XCTAssertEqual(formattedInput3, "A B C")
        
        let formatter4 = ValidationFormatter.uppercased
        let input4 = "a"
        let formattedInput4 = formatter4.formatter(input4)
        XCTAssertEqual(formattedInput4, "A")
    }
    
    // MARK: - Lowercased
    
    func testLowercasedNoChange() {
        let formatter1 = ValidationFormatter.lowercased
        let input1 = "abc"
        let formattedInput1 = formatter1.formatter(input1)
        XCTAssertEqual(formattedInput1, input1)
        
        let formatter2 = ValidationFormatter.lowercased
        let input2 = "1234"
        let formattedInput2 = formatter2.formatter(input2)
        XCTAssertEqual(formattedInput2, input2)
        
        let formatter3 = ValidationFormatter.lowercased
        let input3 = "a b\n c\n d"
        let formattedInput3 = formatter3.formatter(input3)
        XCTAssertEqual(formattedInput3, input3)
        
        let formatter4 = ValidationFormatter.lowercased
        let input4 = "👋 \n 👋"
        let formattedInput4 = formatter4.formatter(input4)
        XCTAssertEqual(formattedInput4, input4)
    }
    
    func testLowercasedChange() {
        let formatter1 = ValidationFormatter.lowercased
        let input1 = "ABC"
        let formattedInput1 = formatter1.formatter(input1)
        XCTAssertEqual(formattedInput1, "abc")
        
        let formatter2 = ValidationFormatter.lowercased
        let input2 = " ABC"
        let formattedInput2 = formatter2.formatter(input2)
        XCTAssertEqual(formattedInput2, " abc")
        
        let formatter3 = ValidationFormatter.lowercased
        let input3 = "A B C"
        let formattedInput3 = formatter3.formatter(input3)
        XCTAssertEqual(formattedInput3, "a b c")
        
        let formatter4 = ValidationFormatter.lowercased
        let input4 = "A"
        let formattedInput4 = formatter4.formatter(input4)
        XCTAssertEqual(formattedInput4, "a")
    }
    
    // MARK: - Limited
    
    func testLimitedToNoChange() {
        let formatter1 = ValidationFormatter.limitedTo(10)
        let input1 = "abc"
        let formattedInput1 = formatter1.formatter(input1)
        XCTAssertEqual(formattedInput1, input1)
        
        let formatter2 = ValidationFormatter.limitedTo(4)
        let input2 = "1234"
        let formattedInput2 = formatter2.formatter(input2)
        XCTAssertEqual(formattedInput2, input2)
        
        let formatter3 = ValidationFormatter.limitedTo(9)
        let input3 = "a b\n c\n d"
        let formattedInput3 = formatter3.formatter(input3)
        XCTAssertEqual(formattedInput3, input3)
        
        let formatter4 = ValidationFormatter.limitedTo(2)
        let input4 = "👋👋"
        let formattedInput4 = formatter4.formatter(input4)
        XCTAssertEqual(formattedInput4, input4)
    }
    
    func testLimitedToChange() {
        let formatter1 = ValidationFormatter.limitedTo(1)
        let input1 = "ABC"
        let formattedInput1 = formatter1.formatter(input1)
        XCTAssertEqual(formattedInput1, "A")
        
        let formatter2 = ValidationFormatter.limitedTo(2)
        let input2 = " ABC"
        let formattedInput2 = formatter2.formatter(input2)
        XCTAssertEqual(formattedInput2, " A")
        
        let formatter3 = ValidationFormatter.limitedTo(0)
        let input3 = "A B C"
        let formattedInput3 = formatter3.formatter(input3)
        XCTAssertEqual(formattedInput3, "")
        
        let formatter4 = ValidationFormatter.limitedTo(2)
        let input4 = "👋👋👋"
        let formattedInput4 = formatter4.formatter(input4)
        XCTAssertEqual(formattedInput4, "👋👋")
    }
    
    // MARK: - Capitalized
    
    func testCapitalizedNoChange() {
        let formatter1 = ValidationFormatter.capitalized
        let input1 = "Abc"
        let formattedInput1 = formatter1.formatter(input1)
        XCTAssertEqual(formattedInput1, input1)
        
        let formatter2 = ValidationFormatter.capitalized
        let input2 = "1234"
        let formattedInput2 = formatter2.formatter(input2)
        XCTAssertEqual(formattedInput2, input2)
        
        let formatter3 = ValidationFormatter.capitalized
        let input3 = "A B\n C\n D"
        let formattedInput3 = formatter3.formatter(input3)
        XCTAssertEqual(formattedInput3, input3)
        
        let formatter4 = ValidationFormatter.capitalized
        let input4 = "👋 \n 👋"
        let formattedInput4 = formatter4.formatter(input4)
        XCTAssertEqual(formattedInput4, input4)
    }
    
    func testCapitalizedChange() {
        let formatter1 = ValidationFormatter.capitalized
        let input1 = "abc"
        let formattedInput1 = formatter1.formatter(input1)
        XCTAssertEqual(formattedInput1, "Abc")
        
        let formatter2 = ValidationFormatter.capitalized
        let input2 = " abc"
        let formattedInput2 = formatter2.formatter(input2)
        XCTAssertEqual(formattedInput2, " Abc")
        
        let formatter3 = ValidationFormatter.capitalized
        let input3 = "a b c"
        let formattedInput3 = formatter3.formatter(input3)
        XCTAssertEqual(formattedInput3, "A B C")
        
        let formatter4 = ValidationFormatter.capitalized
        let input4 = "a"
        let formattedInput4 = formatter4.formatter(input4)
        XCTAssertEqual(formattedInput4, "A")
        
        let formatter5 = ValidationFormatter.capitalized
        let input5 = "abc bc cd"
        let formattedInput5 = formatter5.formatter(input5)
        XCTAssertEqual(formattedInput5, "Abc Bc Cd")
    }
}
