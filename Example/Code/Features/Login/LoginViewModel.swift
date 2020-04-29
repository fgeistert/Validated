//
//  LoginViewModel.swift
//  Example
//
//  Created by Fabian Geistert on 29.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation
import Validated
import Combine

class LoginViewModel {
    
    // MARK: - Validated
    
    @Validated(rules: [.notEmpty, .isEmail], formatters: [.trimmed, .lowercased])
    var email: String?
    
    @Validated(rules: [.notEmpty])
    var password: String?
    
    // MARK: - isValid
    
    var isValid: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest($email, $password)
            .map { (result1, result2) -> Bool in
                return result1.isValid && result2.isValid
            }
            .eraseToAnyPublisher()
    }
}
