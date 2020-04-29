//
//  ValidationRule+Generic.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

public extension ValidationRule {
    static func equalTo(_ input: Value) -> Self {
        return ValidationRule {
            return $0 == input
        }
    }
}

public extension ValidationRule {
    /// careful when using this: chaining has to be implemented manually (see documentation)
    static func equalTo(_ other: Validated<Value>) -> Self {
        return ValidationRule {
            // $0 is not formatted yet, therefore use other.value
            guard let otherValue = other.value else { return false }
            guard type(of: $0) == type(of: otherValue) else { return false }
            return $0 == otherValue
        }
    }
}
