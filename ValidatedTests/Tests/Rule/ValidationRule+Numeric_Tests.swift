//
//  ValidationRule+Numeric_Tests.swift
//  ValidatedTests
//
//  Created by Fabian Geistert on 29.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import XCTest
@testable import Validated

final class ValidationRule_Numeric_Tests: XCTestCase {
    
    // MARK: - greaterThan
    
    func testGreaterThanSuccess() {
        let validation1 = ValidationResult.validate(2, with: .greaterThan(1))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate(1.01, with: .greaterThan(1.0))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate(-1, with: .greaterThan(-2))
        XCTAssertTrue(validation3.isValid)
    }
    
    func testGreaterThanFailure() {
        let validation1 = ValidationResult.validate(0, with: .greaterThan(1))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate(0.999, with: .greaterThan(1.0))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate(-3, with: .greaterThan(-2))
        XCTAssertFalse(validation3.isValid)
    }
    
    // MARK: - greaterOrEqualThan
    
    func testGreaterOrEqualThanSuccess() {
        let validation1 = ValidationResult.validate(2, with: .greaterOrEqualThan(1))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate(1.01, with: .greaterOrEqualThan(1.0))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate(-1, with: .greaterOrEqualThan(-2))
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate(1, with: .greaterOrEqualThan(1))
        XCTAssertTrue(validation4.isValid)
        
        let validation5 = ValidationResult.validate(1.0, with: .greaterOrEqualThan(1.0))
        XCTAssertTrue(validation5.isValid)
        
        let validation6 = ValidationResult.validate(-1, with: .greaterOrEqualThan(-1))
        XCTAssertTrue(validation6.isValid)
    }
    
    func testGreaterOrEqualThanFailure() {
        let validation1 = ValidationResult.validate(0, with: .greaterOrEqualThan(1))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate(0.999, with: .greaterOrEqualThan(1.0))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate(-3, with: .greaterOrEqualThan(-2))
        XCTAssertFalse(validation3.isValid)
    }
    
    // MARK: - smallerThan
    
    func testSmallerThanSuccess() {
        let validation1 = ValidationResult.validate(1, with: .smallerThan(2))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate(1.0, with: .smallerThan(1.01))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate(-2, with: .smallerThan(-1))
        XCTAssertTrue(validation3.isValid)
    }
    
    func testSmallerThanFailure() {
        let validation1 = ValidationResult.validate(1, with: .smallerThan(0))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate(1.0, with: .smallerThan(0.999))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate(-2, with: .smallerThan(-3))
        XCTAssertFalse(validation3.isValid)
    }
    
    // MARK: - smallerOrEqualThan
    
    func testSmallerOrEqualThanSuccess() {
        let validation1 = ValidationResult.validate(1, with: .smallerOrEqualThan(2))
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate(1.0, with: .smallerOrEqualThan(1.01))
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate(-2, with: .smallerOrEqualThan(-1))
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate(1, with: .smallerOrEqualThan(1))
        XCTAssertTrue(validation4.isValid)
        
        let validation5 = ValidationResult.validate(1.0, with: .smallerOrEqualThan(1.0))
        XCTAssertTrue(validation5.isValid)
        
        let validation6 = ValidationResult.validate(-1, with: .smallerOrEqualThan(-1))
        XCTAssertTrue(validation6.isValid)
    }
    
    func testSmallerOrEqualThanFailure() {
        let validation1 = ValidationResult.validate(1, with: .smallerOrEqualThan(0))
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate(1.0, with: .smallerOrEqualThan(0.999))
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate(-2, with: .smallerOrEqualThan(-3))
        XCTAssertFalse(validation3.isValid)
    }
}
