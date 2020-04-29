//
//  ValidationRule+Special.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation

public extension ValidationRule where Value == String {
    static var isEmail: Self {
        return .regex("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    }
}

public extension ValidationRule where Value == String {
    static var isURL: Self {
        return ValidationRule {
            do {
                let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
                if let match = detector.firstMatch(in: $0, options: [], range: NSRange(location: 0, length: $0.utf16.count)) {
                    // it is a link, if the match covers the whole string
                    return match.range.length == $0.utf16.count
                } else {
                    return false
                }
            } catch {
                return false
            }
        }
    }
}
