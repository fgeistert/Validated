//
//  ValidationRule+Bool_Tests.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import XCTest
@testable import Validated

final class ValidationRule_Bool_Tests: XCTestCase {
    func testTrueIsEqualToTrue() {
        let validation = ValidationResult.validate(true, with: .equalTo(true))
        XCTAssertTrue(validation.isValid)
    }
    
    func testFalseIsEqualToFalse() {
        let validation = ValidationResult.validate(false, with: .equalTo(false))
        XCTAssertTrue(validation.isValid)
    }
    
    func testFalseIsEqualToTrue() {
        let validation = ValidationResult.validate(false, with: .equalTo(true))
        XCTAssertFalse(validation.isValid)
    }
    
    func testTrueIsEqualToFalse() {
        let validation = ValidationResult.validate(false, with: .equalTo(true))
        XCTAssertFalse(validation.isValid)
    }
    
    func testTrueIsTrue() {
        let validation = ValidationResult.validate(true, with: .isTrue)
        XCTAssertTrue(validation.isValid)
    }
    
    func testTrueIsNotFalse() {
        let validation = ValidationResult.validate(true, with: .isFalse)
        XCTAssertFalse(validation.isValid)
    }
    
    func testFalseIsFalse() {
        let validation = ValidationResult.validate(false, with: .isFalse)
        XCTAssertTrue(validation.isValid)
    }
    
    func testFalseIsNotTrue() {
        let validation = ValidationResult.validate(false, with: .isTrue)
        XCTAssertFalse(validation.isValid)
    }
}
