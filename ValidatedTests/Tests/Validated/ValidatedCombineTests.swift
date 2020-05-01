//
//  ValidatedCombineTests.swift
//  ValidatedTests
//
//  Created by Fabian Geistert on 01.05.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import XCTest
import Combine
@testable import Validated

@available(iOS 13.0, *)
final class ValidatedCombine_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    @Validated(rule: .minLength(2), formatter: .trimmed)
    var test1: String?
    
    func testValidationResultPublisher() {
        XCTAssertFalse(_test1.result.isValid)
        
        let expectation1 = XCTestExpectation(description: "initial value")
        let expectation2 = XCTestExpectation(description: "other value")
        
        $test1.sink { (result) in
            if result.isValid {
                expectation2.fulfill()
            } else {
                expectation1.fulfill()
            }
        }.store(in: &cancellables)
        
        test1 = " ab  "
        
        wait(for: [expectation1, expectation2], timeout: 1, enforceOrder: true)
    }
    
    @Validated(rule: .minLength(2), formatter: .trimmed)
    var test2: String?
    
    func testValuePublisher() {
        XCTAssertFalse(_test2.result.isValid)
        
        let expectation1 = XCTestExpectation()
        
        _test2.valuePublisher().sink { (value) in
            if value == "ab" {
                expectation1.fulfill()
            }
        }.store(in: &cancellables)
        
        test2 = " ab  "
        
        wait(for: [expectation1], timeout: 1)
    }
}
