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
}
