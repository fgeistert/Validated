//
//  ValidationRule+Collection.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation

public extension ValidationRule where Value: Collection {
    static var notEmpty: Self {
        return ValidationRule {
            return !$0.isEmpty
        }
    }
    
    static func minCount(_ elementCount: Int) -> Self {
        return ValidationRule {
            return $0.count >= elementCount
        }
    }
    
    static func maxCount(_ elementCount: Int) -> Self {
        return ValidationRule {
            return $0.count <= elementCount
        }
    }
    
    static func exactCount(_ elementCount: Int) -> Self {
        return ValidationRule {
            return $0.count == elementCount
        }
    }
}
