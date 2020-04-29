//
//  ValidationFormatter+Numeric.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation

public extension ValidationFormatter where Value: Numeric, Value: Comparable {
    static func clamped(_ range: ClosedRange<Value>) -> Self {
        return ValidationFormatter {
            return max(min($0, range.upperBound), range.lowerBound)
        }
    }
}
