//
//  Publisher+BindToErrorLabel.swift
//  Example
//
//  Created by Fabian Geistert on 28.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

#if canImport(Combine)

import UIKit
import Validated
import Combine

extension Publisher {
    func bindValidationStateTo<View: UIView, Value: Validatable>(view: View) -> AnyPublisher<Self.Output, Self.Failure> where Self.Output == ValidationResult<Value> {
        return self
            .dropFirst()
            .map { [weak view] (state) -> ValidationResult<Value> in
                switch state {
                case .notValid:
                    view?.isHidden = false
                case .valid:
                    view?.isHidden = true
                }

                return state
            }
            .eraseToAnyPublisher()
    }
    
    func bindValidationStateTo<View: UILabel, Value: Validatable>(view: View, with errorMessage: String) -> AnyPublisher<Self.Output, Self.Failure> where Self.Output == ValidationResult<Value>  {
        return self
            .bindValidationStateTo(view: view)
            .map { [weak view] (state) -> ValidationResult<Value> in
                view?.text = errorMessage
                return state
            }
            .eraseToAnyPublisher()
    }
}

#endif
