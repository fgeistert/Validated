//
//  ValidationRule+String_Tests.swift
//  ValidatedTests
//
//  Created by Fabian Geistert on 30.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import XCTest
@testable import Validated

final class ValidationRule_String_Tests: XCTestCase {
    
    // MARK: - Regex
    
    func testRegexSuccess() {
        let validation1 = ValidationResult.validate("123", with: .regex("[0-9]+$"))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("abc", with: .regex("[a-z]+$"))
        XCTAssertTrue(validation2.isValid)
    }
    
    func testRegexFailure() {
        let validation1 = ValidationResult.validate("abc", with: .regex("[0-9]+$"))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("123abc", with: .regex("[0-9]+$"))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate("abc", with: .regex("[A-Z]+$"))
        XCTAssertFalse(validation3.isValid)
    }
}
