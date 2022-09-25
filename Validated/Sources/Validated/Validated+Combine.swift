//
//  Validated+Combine.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

#if canImport(Combine)

import Foundation
import Combine

// MARK: - Validated+Publisher

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension Validated {
    
    func validationPublisher(callbackQueue: DispatchQueue = .main) -> AnyPublisher<ValidationResult<Value>, Never> {
        guard let subject = _subject else {
            return Just(ValidationResult.notValid)
                .receive(on: callbackQueue)
                .eraseToAnyPublisher()
        }
        
        return subject
            .validatedValue
            .receive(on: callbackQueue)
            .eraseToAnyPublisher()
    }
    
    func valuePublisher(callbackQueue: DispatchQueue = .main) -> AnyPublisher<Value, Never> {
        guard let subject = _subject else {
            return Empty(outputType: Value.self, failureType: Never.self)
                .receive(on: callbackQueue)
                .eraseToAnyPublisher()
        }
        
        return subject
            .validatedValue
            .compactMap { (result) -> Value? in
                return result.value
            }
            .receive(on: callbackQueue)
            .eraseToAnyPublisher()
    }
}

#endif
