//
//  ValidationRule_Tests.swift
//  ValidatedTests
//
//  Created by Fabian Geistert on 28.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import XCTest
@testable import Validated

final class ValidationRule_Tests: XCTestCase {
    
    func testInit() {
        let rule: ValidationRule<Int> = ValidationRule { (value) -> Bool in
            return value == 1
        }
        
        let input = 1
        let isValid = rule.check(input)
        
        XCTAssertTrue(isValid)
    }
}
