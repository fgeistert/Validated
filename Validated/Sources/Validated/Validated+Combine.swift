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
        return _subject
            .validatedValue
            .receive(on: callbackQueue)
            .eraseToAnyPublisher()
    }
    
    func valuePublisher(callbackQueue: DispatchQueue = .main) -> AnyPublisher<Value, Never> {
        return _subject
            .validatedValue
            .compactMap { (result) -> Value? in
                return result.value
            }
            .receive(on: callbackQueue)
            .eraseToAnyPublisher()
    }
}

#endif
