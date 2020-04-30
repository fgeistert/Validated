//
//  ValidationRule+StringProtocol_Tests.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import XCTest
@testable import Validated

final class ValidationRule_StringProtocol_Tests: XCTestCase {
    
    // MARK: - notEmpty
    
    func testNotEmptySuccess() {
        let validation1 = ValidationResult.validate("a", with: .notEmpty)
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate(" ", with: .notEmpty)
        XCTAssertTrue(validation2.isValid)
    }
    
    func testNotEmptyFailure() {
        let validation1 = ValidationResult.validate("", with: .notEmpty)
        XCTAssertFalse(validation1.isValid)
    }
    
    // MARK: - contains
    
    func testContainsSuccess() {
        let validation1 = ValidationResult.validate("a", with: .contains("a"))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate(" ", with: .contains(" "))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate(" bza", with: .contains("a"))
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate("aaa", with: .contains("a"))
        XCTAssertTrue(validation4.isValid)
        
        let validation5 = ValidationResult.validate("bbaaabb", with: .contains("aaa"))
        XCTAssertTrue(validation5.isValid)
        
        let validation6 = ValidationResult.validate("bbaaabb", with: .contains("ab"))
        XCTAssertTrue(validation6.isValid)
    }
    
    func testContainsFailure() {
        let validation1 = ValidationResult.validate("", with: .contains("a"))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("aabaabaabaab", with: .contains("bba"))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate("A", with: .contains("a"))
        XCTAssertFalse(validation3.isValid)
    }
    
    // MARK: - caseInsensitiveContains
    
    func testCaseInsensitiveContainsSuccess() {
        let validation1 = ValidationResult.validate("A", with: .caseInsensitiveContains("a"))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("A", with: .caseInsensitiveContains("A"))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate(" bZa", with: .caseInsensitiveContains("za"))
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate("AaA", with: .caseInsensitiveContains("aaa"))
        XCTAssertTrue(validation4.isValid)
        
        let validation6 = ValidationResult.validate("bbaaaBbb", with: .caseInsensitiveContains("ab"))
        XCTAssertTrue(validation6.isValid)
    }
    
    func testCaseInsensitiveContainsFailure() {
        let validation1 = ValidationResult.validate("", with: .caseInsensitiveContains("a"))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("aabaabaabaab", with: .caseInsensitiveContains("bba"))
        XCTAssertFalse(validation2.isValid)
    }
    
    // MARK: - containsLetter
    
    func testContainsLetterSuccess() {
        let validation1 = ValidationResult.validate("a", with: .containsLetter)
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate(" 123123b", with: .containsLetter)
        XCTAssertTrue(validation2.isValid)
    }
    
    func testContainsLetterFailure() {
        let validation1 = ValidationResult.validate("", with: .containsLetter)
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("123123", with: .containsLetter)
        XCTAssertFalse(validation2.isValid)
    }
    
    // MARK: - minContainsLetters
    
    func testMinContainsLettersSuccess() {
        let validation1 = ValidationResult.validate("a", with: .minContainsLetters(1))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate(" 123123bac", with: .minContainsLetters(3))
        XCTAssertTrue(validation2.isValid)
    }
    
    func testMinContainsLettersFailure() {
        let validation1 = ValidationResult.validate("", with: .minContainsLetters(1))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("123123", with: .minContainsLetters(1))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate("123A123", with: .minContainsLetters(2))
        XCTAssertFalse(validation3.isValid)
    }
    
    // MARK: - maxContainsLetters
    
    func testMaxContainsLettersSuccess() {
        let validation1 = ValidationResult.validate("a", with: .maxContainsLetters(2))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate(" 123123bac", with: .maxContainsLetters(3))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("", with: .maxContainsLetters(1))
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate("123123", with: .maxContainsLetters(1))
        XCTAssertTrue(validation4.isValid)
    }
    
    func testMaxContainsLettersFailure() {
        let validation1 = ValidationResult.validate("A", with: .maxContainsLetters(0))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("123AA123", with: .maxContainsLetters(1))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate("a123A123b", with: .maxContainsLetters(2))
        XCTAssertFalse(validation3.isValid)
    }
    
    // MARK: - exactContainsLetters
    
    func testExactContainsLettersSuccess() {
        let validation1 = ValidationResult.validate("a", with: .exactContainsLetters(1))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate(" 123123bac", with: .exactContainsLetters(3))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("", with: .exactContainsLetters(0))
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate("123123", with: .exactContainsLetters(0))
        XCTAssertTrue(validation4.isValid)
    }
    
    func testExactContainsLettersFailure() {
        let validation1 = ValidationResult.validate("A", with: .exactContainsLetters(0))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("123AA123", with: .exactContainsLetters(1))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate("a123A123b", with: .exactContainsLetters(2))
        XCTAssertFalse(validation3.isValid)
    }
    
    // MARK: - containsNumber
    
    func testContainsNumberSuccess() {
        let validation1 = ValidationResult.validate("1", with: .containsNumber)
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("asdasdasd1asd", with: .containsNumber)
        XCTAssertTrue(validation2.isValid)
    }
    
    func testContainsNumberFailure() {
        let validation1 = ValidationResult.validate("", with: .containsNumber)
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("ABCDEFG", with: .containsNumber)
        XCTAssertFalse(validation2.isValid)
    }
    
    // MARK: - minContainsNumbers
    
    func testMinContainsNumbersSuccess() {
        let validation1 = ValidationResult.validate("1", with: .minContainsNumbers(1))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate(" 123123bac", with: .minContainsNumbers(3))
        XCTAssertTrue(validation2.isValid)
    }
    
    func testMinContainsNumbersFailure() {
        let validation1 = ValidationResult.validate("", with: .minContainsNumbers(1))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("ABCDEFG", with: .minContainsNumbers(1))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate("1ASAA", with: .minContainsNumbers(2))
        XCTAssertFalse(validation3.isValid)
    }
    
    // MARK: - maxContainsNumbers
    
    func testMaxContainsNumbersSuccess() {
        let validation1 = ValidationResult.validate("1", with: .maxContainsNumbers(2))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate(" asdasd12f1", with: .maxContainsNumbers(3))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("", with: .maxContainsNumbers(1))
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate("abcdefg", with: .maxContainsNumbers(1))
        XCTAssertTrue(validation4.isValid)
    }
    
    func testMaxContainsNumbersFailure() {
        let validation1 = ValidationResult.validate("1", with: .maxContainsNumbers(0))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("123AA123", with: .maxContainsNumbers(1))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate("a123A123b", with: .maxContainsNumbers(2))
        XCTAssertFalse(validation3.isValid)
    }
    
    // MARK: - exactContainsNumbers
    
    func testExactContainsNumbersSuccess() {
        let validation1 = ValidationResult.validate("1", with: .exactContainsNumbers(1))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate(" asdasdq123", with: .exactContainsNumbers(3))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("", with: .exactContainsNumbers(0))
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate("abcdefg", with: .exactContainsNumbers(0))
        XCTAssertTrue(validation4.isValid)
    }
    
    func testExactContainsNumbersFailure() {
        let validation1 = ValidationResult.validate("1", with: .exactContainsNumbers(0))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("123AA123", with: .exactContainsNumbers(1))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate("a123A123b", with: .exactContainsNumbers(2))
        XCTAssertFalse(validation3.isValid)
    }
    
    // MARK: - minLength
    
    func testMinLengthSuccess() {
        let validation1 = ValidationResult.validate("", with: .minLength(0))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("abcdefg", with: .minLength(1))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("   ", with: .minLength(3))
        XCTAssertTrue(validation3.isValid)
    }
    
    func testMinLengthFailure() {
        let validation1 = ValidationResult.validate("", with: .minLength(1))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("12", with: .minLength(3))
        XCTAssertFalse(validation2.isValid)
    }
    
    // MARK: - maxLength
    
    func testMaxLengthSuccess() {
        let validation1 = ValidationResult.validate("123", with: .maxLength(5))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("12345", with: .maxLength(5))
        XCTAssertTrue(validation2.isValid)
    }
    
    func testMaxLengthFailure() {
        let validation1 = ValidationResult.validate("1234", with: .maxLength(3))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("  ", with: .maxLength(1))
        XCTAssertFalse(validation2.isValid)
    }
    
    // MARK: - ofLength
    
    func testOfLengthSuccess() {
        let validation1 = ValidationResult.validate("123", with: .ofLength(3))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("", with: .ofLength(0))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("👋✅❌", with: .ofLength(3))
        XCTAssertTrue(validation3.isValid)
    }
    
    func testOfLengthFailure() {
        let validation1 = ValidationResult.validate("1", with: .ofLength(2))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("👋✅❌", with: .ofLength(1))
        XCTAssertFalse(validation2.isValid)
    }
    
    // MARK: - caseInsensitiveEquals
    
    func testCaseInsensitiveEqualsSuccess() {
        let validation1 = ValidationResult.validate("test1", with: .caseInsensitiveEquals("test1"))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("TEST", with: .caseInsensitiveEquals("TEST"))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("1234", with: .caseInsensitiveEquals("1234"))
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate(",.-", with: .caseInsensitiveEquals(",.-"))
        XCTAssertTrue(validation4.isValid)
        
        let validation5 = ValidationResult.validate("test1", with: .caseInsensitiveEquals("TEST1"))
        XCTAssertTrue(validation5.isValid)
        
        let validation6 = ValidationResult.validate("TeSt", with: .caseInsensitiveEquals("tEsT"))
        XCTAssertTrue(validation6.isValid)
    }
    
    func testCaseInsensitiveEqualsFailure() {
        let validation1 = ValidationResult.validate("test1", with: .caseInsensitiveEquals("test2"))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("tesT12", with: .caseInsensitiveEquals("TEST1"))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate("✅", with: .caseInsensitiveEquals("❌"))
        XCTAssertFalse(validation3.isValid)
    }
    
    // MARK: - startsWith
    
    func testStartsWithSuccess() {
        let validation1 = ValidationResult.validate("123", with: .startsWith("1"))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("abc", with: .startsWith("a"))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("123", with: .startsWith("123"))
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate("abc", with: .startsWith("abc"))
        XCTAssertTrue(validation4.isValid)
    }
    
    func testStartsWithFailure() {
        let validation1 = ValidationResult.validate("123", with: .startsWith("2"))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("abc", with: .startsWith("A"))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate("abc", with: .startsWith("ABC"))
        XCTAssertFalse(validation3.isValid)
    }
    
    // MARK: - endsWith
    
    func testEndsWithSuccess() {
        let validation1 = ValidationResult.validate("123", with: .endsWith("3"))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("abc", with: .endsWith("c"))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("123", with: .endsWith("123"))
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate("abc", with: .endsWith("abc"))
        XCTAssertTrue(validation4.isValid)
    }
    
    func testEndsWithFailure() {
        let validation1 = ValidationResult.validate("123", with: .endsWith("2"))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("abc", with: .endsWith("C"))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate("abc", with: .endsWith("ABC"))
        XCTAssertFalse(validation3.isValid)
    }
    
    // MARK: - isNumber
    
    func testStringIsNumberSuccess() {
        let validation1 = ValidationResult.validate("1", with: .isNumber)
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("123", with: .isNumber)
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("-5", with: .isNumber)
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate("1.4", with: .isNumber)
        XCTAssertTrue(validation4.isValid)
        
        let validation5 = ValidationResult.validate("12.485", with: .isNumber)
        XCTAssertTrue(validation5.isValid)
        
        let validation6 = ValidationResult.validate("-5.73", with: .isNumber)
        XCTAssertTrue(validation6.isValid)
        
        let validation7 = ValidationResult.validate("0000", with: .isNumber)
        XCTAssertTrue(validation7.isValid)
        
        let validation8 = ValidationResult.validate("0000123", with: .isNumber)
        XCTAssertTrue(validation8.isValid)
    }

    func testStringIsNumberFailure() {
        let validation1 = ValidationResult.validate("A", with: .isNumber)
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("👋", with: .isNumber)
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate("12,2", with: .isNumber)
        XCTAssertFalse(validation3.isValid)
        
        let validation4 = ValidationResult.validate("123,1234", with: .isNumber)
        XCTAssertFalse(validation4.isValid)
        
        let validation5 = ValidationResult.validate("-12,1", with: .isNumber)
        XCTAssertFalse(validation5.isValid)
    }
    
    // MARK: - isInt
    
    func testIsIntSuccess() {
        let validation1 = ValidationResult.validate("1", with: .isInt)
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("1238912381", with: .isInt)
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("-1", with: .isInt)
        XCTAssertTrue(validation3.isValid)
    }
    
    func testIsIntFailure() {
        let validation1 = ValidationResult.validate("A", with: .isInt)
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("jansd12312A", with: .isInt)
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate("12,2", with: .isInt)
        XCTAssertFalse(validation3.isValid)
        
        let validation4 = ValidationResult.validate("12.2", with: .isInt)
        XCTAssertFalse(validation4.isValid)
    }
    
    // MARK: - isDouble
    
    func testIsDoubleSuccess() {
        let validation1 = ValidationResult.validate("1", with: .isDouble)
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("1238912381", with: .isDouble)
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("-1", with: .isDouble)
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate("1.001", with: .isDouble)
        XCTAssertTrue(validation4.isValid)
        
        let validation5 = ValidationResult.validate("1238.912381", with: .isDouble)
        XCTAssertTrue(validation5.isValid)
        
        let validation6 = ValidationResult.validate("-1.1", with: .isDouble)
        XCTAssertTrue(validation6.isValid)
    }
    
    func testIsDoubleFailure() {
        let validation1 = ValidationResult.validate("A", with: .isDouble)
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("jansd12312A", with: .isDouble)
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate("12,2", with: .isDouble)
        XCTAssertFalse(validation3.isValid)
    }
}
