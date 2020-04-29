//
//  ValidationFormatter+Numeric_Tests.swift
//  ValidatedTests
//
//  Created by Fabian Geistert on 28.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import XCTest
@testable import Validated

final class ValidationFormatter_Numeric_Tests: XCTestCase {
    
    func testClampedNoChange() {
        let formatter1 = ValidationFormatter.clamped(1...5)
        let input1 = 1
        let formattedInput1 = formatter1.formatter(input1)
        XCTAssertEqual(formattedInput1, input1)
        
        let formatter2 = ValidationFormatter.clamped(1...5)
        let input2 = 3
        let formattedInput2 = formatter2.formatter(input2)
        XCTAssertEqual(formattedInput2, input2)
        
        let formatter3 = ValidationFormatter.clamped(1...5)
        let input3 = 5
        let formattedInput3 = formatter3.formatter(input3)
        XCTAssertEqual(formattedInput3, input3)
    }
    
    func testClampedChange() {
        let formatter1 = ValidationFormatter.clamped(1...5)
        let input1 = 0
        let formattedInput1 = formatter1.formatter(input1)
        XCTAssertEqual(formattedInput1, 1)
        
        let formatter2 = ValidationFormatter.clamped(1...5)
        let input2 = 6
        let formattedInput2 = formatter2.formatter(input2)
        XCTAssertEqual(formattedInput2, 5)
        
        let formatter3 = ValidationFormatter.clamped(1...5)
        let input3 = -1
        let formattedInput3 = formatter3.formatter(input3)
        XCTAssertEqual(formattedInput3, 1)
    }
}
