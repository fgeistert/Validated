//
//  ValidationRule+Numeric.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation

public extension ValidationRule where Value: Numeric, Value: Comparable {
    static func greaterThan(_ number: Value) -> Self {
        return ValidationRule {
            return $0 > number
        }
    }
    
    static func greaterOrEqualThan(_ number: Value) -> Self {
        return ValidationRule {
            return $0 >= number
        }
    }
    
    static func smallerThan(_ number: Value) -> Self {
        return ValidationRule {
            return $0 < number
        }
    }
    
    static func smallerOrEqualThan(_ number: Value) -> Self {
        return ValidationRule {
            return $0 <= number
        }
    }
}
