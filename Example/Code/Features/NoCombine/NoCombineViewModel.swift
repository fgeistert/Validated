//
//  NoCombineViewModel.swift
//  Example
//
//  Created by Fabian Geistert on 29.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation
import Validated

class NoCombineViewModel {
    
    // MARK: - Validated
    
    @Validated(rules: [.notEmpty, .isEmail], formatters: [.trimmed, .lowercased])
    var email: String?
    
    @Validated(rules: [.notEmpty])
    var password: String?
    
    // MARK: - Results
    
    var emailResult: ValidationResult<String> {
        return _email.result
    }
    
    var passwordResult: ValidationResult<String> {
        return _password.result
    }
    
    // MARK: - isValid
    
    var isValid: Bool {
        return _email.result.isValid && _password.result.isValid
    }
}
