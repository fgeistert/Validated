//
//  ValidationFormatter_Tests.swift
//  ValidatedTests
//
//  Created by Fabian Geistert on 28.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import XCTest
@testable import Validated

final class ValidationFormatter_Tests: XCTestCase {
    
    func testInit() {
        let formatter = ValidationFormatter { (input) -> String in
            return input
        }
        
        let input = "Test"
        let formattedInput = formatter.formatter(input)
        
        XCTAssertEqual(formattedInput, input)
    }
}
