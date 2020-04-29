//
//  ValidationRule+LogicalOperators_Tests.swift
//  ValidatedTests
//
//  Created by Fabian Geistert on 29.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import XCTest
@testable import Validated

final class ValidationRule_LogicalOperators_Tests: XCTestCase {
    
    // MARK: - Or
    
    func testOrSuccess() {
        let validation1 = ValidationResult.validate("b", with: .or(.contains("a"), .contains("b")))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("a", with: .or(.contains("a"), .contains("b")))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("123", with: .isNumber || .equalTo("ok"))
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate("ok", with: .isNumber || .equalTo("ok"))
        XCTAssertTrue(validation4.isValid)
    }
    
    func testOrFailure() {
        let validation1 = ValidationResult.validate("c", with: .or(.contains("a"), .contains("b")))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("nope", with: .isNumber || .equalTo("ok"))
        XCTAssertFalse(validation2.isValid)
    }
    
    // MARK: - And
    
    func testAndSuccess() {
        let validation1 = ValidationResult.validate("ab", with: .and(.contains("a"), .contains("b")))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("123", with: .and(.isNumber, .equalTo("123")))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("ok", with: .notEmpty && .equalTo("ok"))
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate("1A", with: .containsNumber && .containsLetter)
        XCTAssertTrue(validation4.isValid)
    }
    
    func testAndFailure() {
        let validation1 = ValidationResult.validate("a", with: .and(.contains("a"), .contains("b")))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("1234", with: .and(.isNumber, .equalTo("123")))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate(" ", with: .notEmpty && .equalTo("ok"))
        XCTAssertFalse(validation3.isValid)
        
        let validation4 = ValidationResult.validate("12", with: .containsNumber && .containsLetter)
        XCTAssertFalse(validation4.isValid)
    }
    
    // MARK: - Negated
    
    func testNegatedSuccess() {
        let validation1 = ValidationResult.validate("b", with: .negated(.contains("a")))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("ABC", with: !.isNumber)
        XCTAssertTrue(validation2.isValid)
    }
    
    func testNegatedFailure() {
        let validation1 = ValidationResult.validate("a", with: .negated(.contains("a")))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("1", with: !.isNumber)
        XCTAssertFalse(validation2.isValid)
    }
}
