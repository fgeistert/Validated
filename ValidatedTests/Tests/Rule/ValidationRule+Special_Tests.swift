//
//  ValidationRule+Special_Tests.swift
//  ValidatedTests
//
//  Created by Fabian Geistert on 29.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import XCTest
@testable import Validated

final class ValidationRule_Special_Tests: XCTestCase {
    
    // MARK: - isEmail
    
    // taken from: https://gist.github.com/cjaoude/fd9910626629b53c4d25
    func testIsEmailSuccess() {
        let validation1 = ValidationResult.validate("email@example.com", with: .isEmail)
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("firstname.lastname@example.com", with: .isEmail)
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("email@subdomain.example.com", with: .isEmail)
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate("firstname+lastname@example.com", with: .isEmail)
        XCTAssertTrue(validation4.isValid)
        
        let validation5 = ValidationResult.validate("1234567890@example.com", with: .isEmail)
        XCTAssertTrue(validation5.isValid)
        
        let validation6 = ValidationResult.validate("email@example-one.com", with: .isEmail)
        XCTAssertTrue(validation6.isValid)
        
        let validation7 = ValidationResult.validate("_______@example.com", with: .isEmail)
        XCTAssertTrue(validation7.isValid)
        
        let validation8 = ValidationResult.validate("email@example.name", with: .isEmail)
        XCTAssertTrue(validation8.isValid)
        
        let validation9 = ValidationResult.validate("email@example.museum", with: .isEmail)
        XCTAssertTrue(validation9.isValid)
        
        let validation10 = ValidationResult.validate("email@example.co.jp", with: .isEmail)
        XCTAssertTrue(validation10.isValid)
        
        let validation11 = ValidationResult.validate("firstname-lastname@example.com", with: .isEmail)
        XCTAssertTrue(validation11.isValid)
    }
    
    func testIsEmailFailure() {
        let validation1 = ValidationResult.validate("plainaddress", with: .isEmail)
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("#@%^%#$@#$@#.com", with: .isEmail)
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate("@example.com", with: .isEmail)
        XCTAssertFalse(validation3.isValid)
        
        let validation4 = ValidationResult.validate("@@@", with: .isEmail)
        XCTAssertFalse(validation4.isValid)
        
        let validation5 = ValidationResult.validate("email.example.com", with: .isEmail)
        XCTAssertFalse(validation5.isValid)
        
        let validation6 = ValidationResult.validate("あいうえお@example.com", with: .isEmail)
        XCTAssertFalse(validation6.isValid)
        
        let validation7 = ValidationResult.validate("email@example", with: .isEmail)
        XCTAssertFalse(validation7.isValid)
        
        let validation8 = ValidationResult.validate("email@111.222.333.44444", with: .isEmail)
        XCTAssertFalse(validation8.isValid)
        
        let validation9 = ValidationResult.validate("”(),:;<>[\\]@example.com", with: .isEmail)
        XCTAssertFalse(validation9.isValid)
        
        let validation10 = ValidationResult.validate("", with: .isEmail)
        XCTAssertFalse(validation10.isValid)
        
        let validation11 = ValidationResult.validate("   ", with: .isEmail)
        XCTAssertFalse(validation11.isValid)
    }
    
    // MARK: - isURL
    
    func testIsURLSuccess() {
        let validation1 = ValidationResult.validate("https://google.com", with: .isURL)
        XCTAssertTrue(validation1.isValid)
        
        let validation2 = ValidationResult.validate("google.com", with: .isURL)
        XCTAssertTrue(validation2.isValid)
        
        let validation3 = ValidationResult.validate("http://127.0.0.1", with: .isURL)
        XCTAssertTrue(validation3.isValid)
        
        let validation4 = ValidationResult.validate("http://localhost", with: .isURL)
        XCTAssertTrue(validation4.isValid)
        
        let validation5 = ValidationResult.validate("http://8.8.8.8", with: .isURL)
        XCTAssertTrue(validation5.isValid)
        
        let validation6 = ValidationResult.validate("http://google.com", with: .isURL)
        XCTAssertTrue(validation6.isValid)
        
        let validation7 = ValidationResult.validate("ftp://my-server.at", with: .isURL)
        XCTAssertTrue(validation7.isValid)
        
        let validation8 = ValidationResult.validate("my.domain.at", with: .isURL)
        XCTAssertTrue(validation8.isValid)
        
        let validation9 = ValidationResult.validate("http://example.museum", with: .isURL)
        XCTAssertTrue(validation9.isValid)
    }
    
    func testIsURLFailure() {
        let validation1 = ValidationResult.validate("plainaddress", with: .isURL)
        XCTAssertFalse(validation1.isValid)
        
        let validation2 = ValidationResult.validate("http", with: .isURL)
        XCTAssertFalse(validation2.isValid)
        
        let validation3 = ValidationResult.validate("://hello.com", with: .isURL)
        XCTAssertFalse(validation3.isValid)
        
        let validation4 = ValidationResult.validate("@@@", with: .isURL)
        XCTAssertFalse(validation4.isValid)
        
        let validation5 = ValidationResult.validate("127.0.0.1", with: .isURL)
        XCTAssertFalse(validation5.isValid)
        
        let validation6 = ValidationResult.validate("example.domain", with: .isURL)
        XCTAssertFalse(validation6.isValid)
        
        let validation7 = ValidationResult.validate("http:/test.at", with: .isURL)
        XCTAssertFalse(validation7.isValid)
        
        let validation8 = ValidationResult.validate("", with: .isURL)
        XCTAssertFalse(validation8.isValid)
        
        let validation9 = ValidationResult.validate("      ", with: .isURL)
        XCTAssertFalse(validation9.isValid)
    }
}
