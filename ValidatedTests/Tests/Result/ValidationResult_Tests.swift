//
//  ValidationResult_Tests.swift
//  ValidatedTests
//
//  Created by Fabian Geistert on 28.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import XCTest
@testable import Validated

final class ValidationResult_Tests: XCTestCase {
    
    func testIsValid() {
        let result1: ValidationResult<String> = .valid(nil)
        XCTAssertTrue(result1.isValid)
        
        let result2: ValidationResult<String> = .valid("A")
        XCTAssertTrue(result2.isValid)
    }
    
    func testIsNotValid() {
        let result1: ValidationResult<String> = .notValid
        XCTAssertFalse(result1.isValid)
    }
    
    func testValue() {
        let result1: ValidationResult<String> = .valid(nil)
        XCTAssertEqual(result1.value, nil)
        
        let result2: ValidationResult<String> = .valid("A")
        XCTAssertEqual(result2.value, "A")
        
        let result3: ValidationResult<String> = .notValid
        XCTAssertEqual(result3.value, nil)
    }
    
    func testValidations() {
        let result1 = ValidationResult.validate("A", with: .notEmpty)
        XCTAssertTrue(result1.isValid)
        
        let result2 = ValidationResult.validate("AB", with: [.notEmpty, .ofLength(2)])
        XCTAssertTrue(result2.isValid)
        
        let result3 = ValidationResult.validate("", with: .notEmpty)
        XCTAssertFalse(result3.isValid)
        
        let result4 = ValidationResult.validate("", with: [.notEmpty, .ofLength(2)])
        XCTAssertFalse(result4.isValid)
    }
    
    func testFormatters() {
        let result1 = ValidationResult.format(" ", with: .trimmed)
        XCTAssertEqual(result1, "")
        
        let result2 = ValidationResult.format(" a ", with: [.trimmed, .uppercased])
        XCTAssertEqual(result2, "A")
    }
    
    func testEquatable() {
        let result1: ValidationResult<String> = .valid(nil)
        let result2: ValidationResult<String> = .valid("A")
        let result3: ValidationResult<String> = .notValid
        
        XCTAssertEqual(result1, result2)
        XCTAssertNotEqual(result2, result3)
    }
}
