//
//  ValidationRule+String.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation

public extension ValidationRule where Value == String {
    static func regex(_ pattern: String,
                      options: NSRegularExpression.Options = .init(),
                      matchingOptions: NSRegularExpression.MatchingOptions = .init()) -> Self {
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else {
            return ValidationRule { _ in
                return false
            }
        }
        return ValidationRule.regex(regex, matchingOptions: matchingOptions)
    }
        
    static func regex(_ regex: NSRegularExpression, matchingOptions: NSRegularExpression.MatchingOptions = .init()) -> Self {
        return ValidationRule {
            let firstMatch = regex.firstMatch(in: $0, options: matchingOptions, range: .init($0.startIndex..., in: $0))
            return firstMatch != nil
        }
    }
}
