//
//  ValidatedTests.swift
//  ValidatedTests
//
//  Created by Fabian Geistert on 30.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import XCTest
import Combine
@testable import Validated

final class Validated_Tests: XCTestCase {
    
    @Validated(rule: .notEmpty)
    var test1: String?
    
    func testSimpleValidated() {
        XCTAssertFalse(_test1.result.isValid)
        
        test1 = "test"
        XCTAssertTrue(_test1.result.isValid)
        
        test1 = nil
        XCTAssertFalse(_test1.result.isValid)
    }
    
    @Validated(rule: .minLength(2), strategy: .optional)
    var test2: String?
    
    func testOptionalStrategy() {
        XCTAssertTrue(_test2.result.isValid)
        
        test2 = ""
        XCTAssertTrue(_test2.result.isValid)
        
        test2 = "  "
        XCTAssertTrue(_test2.result.isValid)
        
        test2 = "  a"
        XCTAssertTrue(_test2.result.isValid)
    }
    
    @Validated(rule: .minLength(2), strategy: .required)
    var test3: String?
    
    func testRequiredStrategy() {
        XCTAssertFalse(_test3.result.isValid)
        
        test3 = ""
        XCTAssertFalse(_test3.result.isValid)
        
        test3 = "  "
        XCTAssertTrue(_test3.result.isValid)
        
        test3 = "  a"
        XCTAssertTrue(_test3.result.isValid)
    }
    
    @Validated(rule: .minLength(2), formatter: .trimmed)
    var test4: String?
    
    func testFormatterAndRule() {
        XCTAssertFalse(_test4.result.isValid)
        
        test4 = ""
        XCTAssertFalse(_test4.result.isValid)
        
        test4 = "  "
        XCTAssertFalse(_test4.result.isValid)
        
        test4 = "  a   "
        XCTAssertFalse(_test4.result.isValid)
        
        test4 = "  ab  "
        XCTAssertTrue(_test4.result.isValid)
    }
    
    @Validated(rule: .minLength(2), formatter: .trimmed)
    var test5: String?
    
    var cancellables = Set<AnyCancellable>()
    
    func testValidationResultPublisher() {
        XCTAssertFalse(_test5.result.isValid)
        
        let expectation1 = XCTestExpectation(description: "initial value")
        let expectation2 = XCTestExpectation(description: "other value")
        
        $test5.sink { (result) in
            if result.isValid {
                expectation2.fulfill()
            } else {
                expectation1.fulfill()
            }
        }.store(in: &cancellables)
        
        test5 = " ab  "
        
        wait(for: [expectation1, expectation2], timeout: 1, enforceOrder: true)
    }
    
    @Validated(rule: .minLength(2), formatter: .trimmed)
    var test6: String?
    
    func testValuePublisher() {
        XCTAssertFalse(_test5.result.isValid)
        
        let expectation1 = XCTestExpectation()
        
        _test5.valuePublisher().sink { (value) in
            if value == "ab" {
                expectation1.fulfill()
            }
        }.store(in: &cancellables)
        
        test5 = " ab  "
        
        wait(for: [expectation1], timeout: 1)
    }
    
    @Validated(rules: [.minLength(2), .maxLength(5)])
    var test7: String?
    
    func testMultipleRules() {
        XCTAssertFalse(_test7.result.isValid)
        
        test7 = "a"
        XCTAssertFalse(_test7.result.isValid)
        
        test7 = "ab"
        XCTAssertTrue(_test7.result.isValid)
        
        test7 = "abc"
        XCTAssertTrue(_test7.result.isValid)
        
        test7 = "abcd"
        XCTAssertTrue(_test7.result.isValid)
        
        test7 = "abcde"
        XCTAssertTrue(_test7.result.isValid)
        
        test7 = "abcdef"
        XCTAssertFalse(_test7.result.isValid)
    }
    
    @Validated(rule: .notEmpty, formatters: [.trimmed, .uppercased])
    var test8: String?
    
    func testMultipleFormatters() {
        XCTAssertFalse(_test8.result.isValid)
        
        test8 = " "
        XCTAssertFalse(_test8.result.isValid)
        
        test8 = " a"
        XCTAssertTrue(_test8.result.isValid)
        XCTAssertEqual(test8, "A")
        
        test8 = " ab"
        XCTAssertTrue(_test8.result.isValid)
        XCTAssertEqual(test8, "AB")
        
        test8 = "     aXz       "
        XCTAssertTrue(_test8.result.isValid)
        XCTAssertEqual(test8, "AXZ")
        
        test8 = nil
        XCTAssertFalse(_test8.result.isValid)
        XCTAssertEqual(test8, nil)
    }
}
