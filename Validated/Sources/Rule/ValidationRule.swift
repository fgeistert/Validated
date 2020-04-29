//
//  ValidationRule.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation

public struct ValidationRule<Value: Validatable> {
    internal init(_ check: @escaping ((Value) -> Bool)) {
        self.check = check
    }
    
    let check: ((Value) -> Bool)
}
