//
//  Validated.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation

#if canImport(Combine)
import Combine
#endif

@propertyWrapper
public class Validated<Value: Validatable> {
    
    // MARK: - Private
    
    private var __subject: Any?
    
    private var strategy: ValidationStrategy = .required
    private var rules: [ValidationRule<Value>]? = nil
    private var formatters: [ValidationFormatter<Value>]? = nil
    
    internal var value: Value? {
        didSet {
            postValueOnFirstAssign()
        }
    }
    
    private func postValueOnFirstAssign() {
        if #available(iOS 13.0, *) {
            #if canImport(Combine)
            _subject?.validatedValue.value = result
            #endif
        }
    }
    
    private func setupSubjectIfPossible() {
        if #available(iOS 13.0, *) {
            #if canImport(Combine)
            _subject = ValidatedSubject()
            #endif
        }
    }
    
    // MARK: - Initializers
    
    public init(strategy: ValidationStrategy = .required) {
        value = nil
        self.strategy = strategy
        setupSubjectIfPossible()
        postValueOnFirstAssign()
    }
    
    public init(rule: ValidationRule<Value>, strategy: ValidationStrategy = .required) {
        value = nil
        self.rules = [rule]
        self.strategy = strategy
        setupSubjectIfPossible()
        postValueOnFirstAssign()
    }
    
    public init(rules: [ValidationRule<Value>], strategy: ValidationStrategy = .required) {
        value = nil
        self.rules = rules
        self.strategy = strategy
        setupSubjectIfPossible()
        postValueOnFirstAssign()
    }
    
    public init(rule: ValidationRule<Value>, formatter: ValidationFormatter<Value>, strategy: ValidationStrategy = .required) {
        value = nil
        self.rules = [rule]
        self.formatters = [formatter]
        self.strategy = strategy
        setupSubjectIfPossible()
        postValueOnFirstAssign()
    }
    
    public init(rules: [ValidationRule<Value>], formatter: ValidationFormatter<Value>, strategy: ValidationStrategy = .required) {
        value = nil
        self.rules = rules
        self.formatters = [formatter]
        self.strategy = strategy
        setupSubjectIfPossible()
        postValueOnFirstAssign()
    }
    
    public init(rule: ValidationRule<Value>, formatters: [ValidationFormatter<Value>], strategy: ValidationStrategy = .required) {
        value = nil
        self.rules = [rule]
        self.formatters = formatters
        self.strategy = strategy
        setupSubjectIfPossible()
        postValueOnFirstAssign()
    }
    
    public init(rules: [ValidationRule<Value>], formatters: [ValidationFormatter<Value>], strategy: ValidationStrategy = .required) {
        value = nil
        self.rules = rules
        self.formatters = formatters
        self.strategy = strategy
        setupSubjectIfPossible()
        postValueOnFirstAssign()
    }
    
    // MARK: - Wrapped Value
    
    public var wrappedValue: Value? {
        get {
            var formattedValue: Value? = value
            
            if let value = formattedValue, let formatters = formatters {
                formattedValue = ValidationResult.format(value, with: formatters)
            }
            
            // reset to nil for empty strings if strategy == .optional
            if let stringValue = formattedValue as? String {
                if stringValue.isEmpty, strategy == .optional {
                    formattedValue = nil
                }
            }
            
            return formattedValue
        }
        set {
            value = newValue
        }
    }
    
    // MARK: - Public Properties
    
    public var result: ValidationResult<Value> {
        if let wrappedValue = wrappedValue, let rules = rules {
            return ValidationResult<Value>.validate(wrappedValue, with: rules)
        }
        
        switch strategy {
        case .required:
            return .notValid
        case .optional:
            return .valid(nil)
        }
    }
    
    /// use this to manually invoke the validation chain
    public func reValidate() {
        let newValue = value
        value = newValue
    }
    
    public func resetValidation() {
        value = nil
    }
    
    // MARK: - Optional Combine Extensions
    
    #if canImport(Combine)
    @available(iOS 13.0, *)
    internal struct ValidatedSubject {
        var validatedValue = CurrentValueSubject<ValidationResult<Value>, Never>(.notValid)
    }
    
    @available(iOS 13.0, *)
    internal var _subject: ValidatedSubject? {
        get {
            return __subject as? ValidatedSubject
        }
        set {
            __subject = newValue
        }
    }
    
    @available(iOS 13.0, *)
    public var projectedValue: AnyPublisher<ValidationResult<Value>, Never> {
        return validationPublisher()
    }
    #endif
}
