//
//  ValidationResult.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation

public enum ValidationResult<Value: Validatable> {
    
    // value is optional, because it can be valid, without having a value (if strategy == .optional)
    case valid(_ value: Value?)
    case notValid
    
    public var isValid: Bool {
        switch self {
        case .valid:
            return true
        case .notValid:
            return false
        }
    }
    
    public var value: Value? {
        switch self {
        case .valid(let value):
            return value
        case .notValid:
            return nil
        }
    }
}

public extension ValidationResult {
    static func validate(_ input: Value, with rules: [ValidationRule<Value>]) -> ValidationResult<Value> {
        let allValid = rules.allSatisfy { (rule) -> Bool in
            return rule.check(input)
        }
        
        return allValid ? .valid(input) : .notValid
    }
    
    static func validate(_ input: Value, with rule: ValidationRule<Value>) -> ValidationResult<Value> {
        let result = rule.check(input)
        
        return result ? .valid(input) : .notValid
    }
    
    static func format(_ input: Value, with formatter: ValidationFormatter<Value>) -> Value {
        return formatter.formatter(input)
    }
    
    static func format(_ input: Value, with formatters: [ValidationFormatter<Value>]) -> Value {
        var formattedInput = input
        formatters.forEach { (formatter) in
            formattedInput = formatter.formatter(formattedInput)
        }
        return formattedInput
    }
}

extension ValidationResult: Equatable {
}

public func == <Value: Validatable>(lhs: ValidationResult<Value>, rhs: ValidationResult<Value>) -> Bool {
    switch (lhs, rhs) {
    case (.valid, .valid):
        return true
    case (.notValid, .notValid):
        return true

    default:
        return false
    }
}
