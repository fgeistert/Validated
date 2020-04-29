//
//  PasswordViewModel.swift
//  Example
//
//  Created by Fabian Geistert on 29.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation
import Validated
import Combine

class PasswordViewModel {
    
    // MARK: - Validated
    
    @Validated(rules: [.containsLetter, .containsNumber, !.contains("y"), .minLength(8)])
    var password: String?
    
    // MARK: - isValid
    
    var isValid: AnyPublisher<Bool, Never> {
        return $password
            .map { (result) -> Bool in
                return result.isValid
            }
            .eraseToAnyPublisher()
    }
}
