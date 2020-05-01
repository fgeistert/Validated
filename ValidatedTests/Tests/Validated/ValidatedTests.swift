//
//  ValidatedTests.swift
//  ValidatedTests
//
//  Created by Fabian Geistert on 30.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import XCTest
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
    
    @Validated(rules: [.minLength(2), .maxLength(5)])
    var test5: String?
    
    func testMultipleRules() {
        XCTAssertFalse(_test5.result.isValid)
        
        test5 = "a"
        XCTAssertFalse(_test5.result.isValid)
        
        test5 = "ab"
        XCTAssertTrue(_test5.result.isValid)
        
        test5 = "abc"
        XCTAssertTrue(_test5.result.isValid)
        
        test5 = "abcd"
        XCTAssertTrue(_test5.result.isValid)
        
        test5 = "abcde"
        XCTAssertTrue(_test5.result.isValid)
        
        test5 = "abcdef"
        XCTAssertFalse(_test5.result.isValid)
    }
    
    @Validated(rule: .notEmpty, formatters: [.trimmed, .uppercased])
    var test6: String?
    
    func testMultipleFormatters() {
        XCTAssertFalse(_test6.result.isValid)
        
        test6 = " "
        XCTAssertFalse(_test6.result.isValid)
        
        test6 = " a"
        XCTAssertTrue(_test6.result.isValid)
        XCTAssertEqual(test6, "A")
        
        test6 = " ab"
        XCTAssertTrue(_test6.result.isValid)
        XCTAssertEqual(test6, "AB")
        
        test6 = "     aXz       "
        XCTAssertTrue(_test6.result.isValid)
        XCTAssertEqual(test6, "AXZ")
        
        test6 = nil
        XCTAssertFalse(_test6.result.isValid)
        XCTAssertEqual(test6, nil)
    }
}
