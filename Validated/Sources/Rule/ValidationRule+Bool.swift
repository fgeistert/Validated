//
//  ValidationRule+Bool.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation

public extension ValidationRule where Value == Bool {
    static var isTrue: Self {
        return ValidationRule {
            return $0 == true
        }
    }
    
    static var isFalse: Self {
        return ValidationRule {
            return $0 == false
        }
    }
}
