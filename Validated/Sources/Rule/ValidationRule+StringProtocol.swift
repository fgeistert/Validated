//
//  ValidationRule+StringProtocol.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation

public extension ValidationRule where Value: StringProtocol {
    static var notEmpty: Self {
        return ValidationRule {
            return !$0.isEmpty
        }
    }
    
    static func contains(_ input: Value) -> Self {
        return ValidationRule {
            return $0.contains(input)
        }
    }
    
    static func caseInsensitiveContains(_ input: Value) -> Self {
        return ValidationRule {
            return $0.range(of: input, options: .caseInsensitive) != nil
        }
    }
    
    static var containsLetter: Self {
        return ValidationRule {
            return $0.rangeOfCharacter(from: CharacterSet.letters) != nil
        }
    }
    
    static func minContainsLetters(_ characterCount: Int) -> Self {
        return ValidationRule {
            return $0.filter { $0.isLetter }.count >= characterCount
        }
    }
    
    static func maxContainsLetters(_ characterCount: Int) -> Self {
        return ValidationRule {
            return $0.filter { $0.isLetter }.count <= characterCount
        }
    }
    
    static func exactContainsLetters(_ characterCount: Int) -> Self {
        return ValidationRule {
            return $0.filter { $0.isLetter }.count == characterCount
        }
    }
    
    static var containsNumber: Self {
        return ValidationRule {
            return $0.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
        }
    }
    
    static func minContainsNumbers(_ numberCount: Int) -> Self {
        return ValidationRule {
            return $0.filter { $0.isNumber }.count >= numberCount
        }
    }
    
    static func maxContainsNumbers(_ characterCount: Int) -> Self {
        return ValidationRule {
            return $0.filter { $0.isNumber }.count <= characterCount
        }
    }
    
    static func exactContainsNumbers(_ characterCount: Int) -> Self {
        return ValidationRule {
            return $0.filter { $0.isNumber }.count == characterCount
        }
    }
    
    static func minLength(_ characterCount: Int) -> Self {
        return ValidationRule {
            return $0.count >= characterCount
        }
    }
    
    static func maxLength(_ characterCount: Int) -> Self {
        return ValidationRule {
            return $0.count <= characterCount
        }
    }
    
    static func ofLength(_ characterCount: Int) -> Self {
        return ValidationRule {
            return $0.count == characterCount
        }
    }
    
    static func caseInsensitiveEquals(_ input: Value) -> Self {
        return ValidationRule {
            return $0.caseInsensitiveCompare(input) == .orderedSame
        }
    }
    
    static func startsWith(_ input: Value) -> Self {
        return ValidationRule {
            return $0.hasPrefix(input)
        }
    }
    
    static func endsWith(_ input: Value) -> Self {
        return ValidationRule {
            return $0.hasSuffix(input)
        }
    }
    
    static var isNumber: Self {
        return ValidationRule {
            return ValidationRule.or(isInt, isDouble).check($0)
        }
    }
    
    static var isInt: Self {
        return ValidationRule {
            return Int($0) != nil
        }
    }
    
    static var isDouble: Self {
        return ValidationRule {
            return Double($0) != nil
        }
    }
}
