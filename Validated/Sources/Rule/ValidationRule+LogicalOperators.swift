//
//  ValidationRule+LogicalOperators.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation

public extension ValidationRule {
    static func or(_ rules: ValidationRule...) -> Self {
        let neededChecks = rules.map { $0.check }
        return ValidationRule { input in
            let states = neededChecks.map { (check) in
                return check(input)
            }
            return states.contains { $0 }
        }
    }
    
    static func and(_ rules: ValidationRule...) -> Self {
        let neededChecks = rules.map { $0.check }
        return ValidationRule { input in
            let states = neededChecks.map { (check) in
                return check(input)
            }
            return states.allSatisfy { $0 }
        }
    }
    
    static func negated(_ rule: ValidationRule) -> Self {
        return ValidationRule { input in
            let state = rule.check(input)
            return !state
        }
    }
}

public extension ValidationRule {
    static func ||(left: ValidationRule, right: ValidationRule) -> ValidationRule {
        return .or(left, right)
    }
    
    static func &&(left: ValidationRule, right: ValidationRule) -> ValidationRule {
        return .and(left, right)
    }
    
    static prefix func !(rule: ValidationRule) -> ValidationRule {
        return .negated(rule)
    }
}
