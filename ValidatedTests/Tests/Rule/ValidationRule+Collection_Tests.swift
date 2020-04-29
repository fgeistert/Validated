//
//  ValidationRule+Collection_Tests.swift
//  ValidatedTests
//
//  Created by Fabian Geistert on 28.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import XCTest
@testable import Validated

final class ValidationRule_Collection_Tests: XCTestCase {
    
    // MARK: - notEmpty
    
    func testNotEmptySuccess() {
        let array: [Int] = [1, 2, 3]
        let validation1 = ValidationResult.validate(array, with: .notEmpty)
        XCTAssertTrue(validation1.isValid)
        
        let set: Set<Bool> = [true]
        let validation2 = ValidationResult.validate(set, with: .notEmpty)
        XCTAssertTrue(validation2.isValid)
        
        let dictionary: [Int: Int] = [1: 1]
        let validation3 = ValidationResult.validate(dictionary, with: .notEmpty)
        XCTAssertTrue(validation3.isValid)
    }
    
    func testNotEmptyFailure() {
        let array: [Int] = []
        let validation1 = ValidationResult.validate(array, with: .notEmpty)
        XCTAssertFalse(validation1.isValid)
        
        let set: Set<Bool> = []
        let validation2 = ValidationResult.validate(set, with: .notEmpty)
        XCTAssertFalse(validation2.isValid)
        
        let dictionary: [Int: Int] = [:]
        let validation3 = ValidationResult.validate(dictionary, with: .notEmpty)
        XCTAssertFalse(validation3.isValid)
    }
    
    // MARK: - minCount
    
    func testMinCountSuccess() {
        let array: [Int] = [1, 2, 3]
        let validation1 = ValidationResult.validate(array, with: .minCount(3))
        XCTAssertTrue(validation1.isValid)
        
        let set: Set<Bool> = [true]
        let validation2 = ValidationResult.validate(set, with: .minCount(1))
        XCTAssertTrue(validation2.isValid)
        
        let dictionary: [Int: Int] = [1: 1]
        let validation3 = ValidationResult.validate(dictionary, with: .minCount(1))
        XCTAssertTrue(validation3.isValid)
    }
    
    func testMinCountFailure() {
        let array: [Int] = []
        let validation1 = ValidationResult.validate(array, with: .minCount(3))
        XCTAssertFalse(validation1.isValid)
        
        let set: Set<Bool> = []
        let validation2 = ValidationResult.validate(set, with: .minCount(1))
        XCTAssertFalse(validation2.isValid)
        
        let dictionary: [Int: Int] = [:]
        let validation3 = ValidationResult.validate(dictionary, with: .minCount(1))
        XCTAssertFalse(validation3.isValid)
    }
    
    // MARK: - maxCount
    
    func testMaxCountSuccess() {
        let array: [Int] = [1, 2, 3]
        let validation1 = ValidationResult.validate(array, with: .maxCount(3))
        XCTAssertTrue(validation1.isValid)
        
        let set: Set<Bool> = [true]
        let validation2 = ValidationResult.validate(set, with: .maxCount(1))
        XCTAssertTrue(validation2.isValid)
        
        let dictionary: [Int: Int] = [1: 1]
        let validation3 = ValidationResult.validate(dictionary, with: .maxCount(1))
        XCTAssertTrue(validation3.isValid)
        
        let set2: Set<Bool> = [true, true]
        let validation4 = ValidationResult.validate(set2, with: .maxCount(1))
        XCTAssertTrue(validation4.isValid)
    }
    
    func testMaxCountFailure() {
        let array: [Int] = [1, 2]
        let validation1 = ValidationResult.validate(array, with: .maxCount(1))
        XCTAssertFalse(validation1.isValid)
        
        let set: Set<Bool> = [true, false]
        let validation2 = ValidationResult.validate(set, with: .maxCount(1))
        XCTAssertFalse(validation2.isValid)
        
        let dictionary: [Int: Int] = [1: 1, 2: 2]
        let validation3 = ValidationResult.validate(dictionary, with: .maxCount(1))
        XCTAssertFalse(validation3.isValid)
    }
    
    // MARK: - exactCount
    
    func testExactCountSuccess() {
        let array: [Int] = [1, 2, 3]
        let validation1 = ValidationResult.validate(array, with: .exactCount(3))
        XCTAssertTrue(validation1.isValid)
        
        let set: Set<Bool> = [true]
        let validation2 = ValidationResult.validate(set, with: .exactCount(1))
        XCTAssertTrue(validation2.isValid)
        
        let dictionary: [Int: Int] = [1: 1]
        let validation3 = ValidationResult.validate(dictionary, with: .exactCount(1))
        XCTAssertTrue(validation3.isValid)
    }
    
    func testExactCountFailure() {
        let array: [Int] = []
        let validation1 = ValidationResult.validate(array, with: .exactCount(3))
        XCTAssertFalse(validation1.isValid)
        
        let set: Set<Bool> = [true, false]
        let validation2 = ValidationResult.validate(set, with: .exactCount(1))
        XCTAssertFalse(validation2.isValid)
        
        let dictionary: [Int: Int] = [:]
        let validation3 = ValidationResult.validate(dictionary, with: .exactCount(1))
        XCTAssertFalse(validation3.isValid)
    }
}
