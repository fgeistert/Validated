//
//  ValidationFormatter+String.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation

public extension ValidationFormatter where Value == String {
    static var trimmed: Self {
        return .trimmed(with: .whitespaces)
    }
    
    static func trimmed(with options: CharacterSet) -> Self {
        return ValidationFormatter {
            return $0.trimmingCharacters(in: options)
        }
    }
    
    static var uppercased: Self {
        return ValidationFormatter {
            return $0.uppercased()
        }
    }
    
    static var lowercased: Self {
        return ValidationFormatter {
            return $0.lowercased()
        }
    }
    
    static func limitedTo(_ chars: Int) -> Self {
        return ValidationFormatter {
            return String($0.prefix(chars))
        }
    }
    
    static var capitalized: Self {
        return ValidationFormatter {
            return $0.capitalized
        }
    }
}
