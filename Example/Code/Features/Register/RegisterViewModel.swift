//
//  RegisterViewModel.swift
//  Example
//
//  Created by Fabian Geistert on 28.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation
import Validated
import Combine

class RegisterViewModel {
    
    // MARK: - Validated
    
    @Validated(rules: [.or(.contains("a"), .contains("b")), .negated(.contains("p")), .minLength(6)], formatter: .trimmed)
    var userName: String?
    
    @Validated(rule: .isEmail, formatters: [.trimmed, .lowercased])
    var email: String?
    
    @Validated(rule: .isURL, formatters: [.trimmed, .lowercased], strategy: .optional)
    var website: String?
    
    @Validated(rule: .minLength(8))
    var password: String?
    
    var cancellable: AnyCancellable?
    
    // we can't access @Validated(rules: [.equalTo(_password)]) because self is not available yet
    lazy var repeatPassword: Validated<String> = {
        let validated = Validated(rule: .equalTo(_password))
        
        // react to _password changes
        cancellable = _password.projectedValue
            .drop(while: { (result) -> Bool in
                return !result.isValid || validated.wrappedValue == nil
            })
            .sink { (_) in
                validated.reValidate()
            }
        
        return validated
    }()
    
    @Validated(rule: .isTrue)
    var termsAccepted: Bool?
    
    // MARK: - isValid
    
    private var _isValid1: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest4($userName, $email, $website, $password)
            .map { (userName, email, website, password) -> Bool in
                return userName.isValid && email.isValid && website.isValid && password.isValid
            }
            .eraseToAnyPublisher()
    }
    
    private var _isValid2: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(repeatPassword.projectedValue, $termsAccepted)
            .map { (repeatPassword, termsAccepted) -> Bool in
                return repeatPassword.isValid && termsAccepted.isValid
            }
            .eraseToAnyPublisher()
    }
    
    // CombineLatest has a limit of 4 :(
    var isValid: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(_isValid1, _isValid2)
            .map { (isValid1, isValid2) -> Bool in
                return isValid1 && isValid2
            }
            .eraseToAnyPublisher()
    }
}
