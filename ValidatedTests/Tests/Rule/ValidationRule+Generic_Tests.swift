//
//  ValidationRule+Generic_Tests.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import XCTest
@testable import Validated

final class ValidationRule_Generic_Tests: XCTestCase {
    
    // MARK: - String Tests
    
    func testStringIsEqualTo() {
        let validation1 = ValidationResult.validate("test1", with: .equalTo("test1"))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("TEST", with: .equalTo("TEST"))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("1234", with: .equalTo("1234"))
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate(",.-", with: .equalTo(",.-"))
        XCTAssertTrue(validation4.isValid)
    }
    
    func testStringIsNotEqualTo() {
        let validation = ValidationResult.validate("test1", with: .equalTo("test2"))
        XCTAssertFalse(validation.isValid)
    }
    
    func testStringIsNotEqualToCaseSensitive() {
        let validation = ValidationResult.validate("test1", with: .equalTo("TEST1"))
        XCTAssertFalse(validation.isValid)
    }
    
    // MARK: - Int Tests
    
    func testIntIsEqualTo() {
        let validation1 = ValidationResult.validate(1, with: .equalTo(1))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate(891231, with: .equalTo(891231))
        XCTAssertTrue(validation2.isValid)
    }
    
    func testIntIsNotEqualTo() {
        let validation1 = ValidationResult.validate(1, with: .equalTo(2))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate(-1, with: .equalTo(1))
        XCTAssertFalse(validation2.isValid)
    }
    
    // MARK: - Bool Tests
    
    func testBoolIsEqualTo() {
        let validation1 = ValidationResult.validate(true, with: .equalTo(true))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate(false, with: .equalTo(false))
        XCTAssertTrue(validation2.isValid)
    }
    
    func testBoolIsNotEqualTo() {
        let validation1 = ValidationResult.validate(true, with: .equalTo(false))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate(false, with: .equalTo(true))
        XCTAssertFalse(validation2.isValid)
    }
    
    // MARK: - Double Tests
    
    func testDoubleIsEqualTo() {
        let validation1 = ValidationResult.validate(1.24, with: .equalTo(1.24))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate(1.99, with: .equalTo(1.99))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate(1242.23, with: .equalTo(1242.23))
        XCTAssertTrue(validation3.isValid)
    }
    
    func testDoubleIsNotEqualTo() {
        let validation1 = ValidationResult.validate(32.3, with: .equalTo(2.1))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate(-1.2, with: .equalTo(1.2))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate(1.2, with: .equalTo(1.21))
        XCTAssertFalse(validation3.isValid)
    }
}
