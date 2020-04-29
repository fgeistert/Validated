//
//  Strings.swift
//  Example
//
//  Created by Fabian Geistert on 28.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation

struct Strings {
    struct FormErrors {
        static let generic = "Error"
        
        static let termsNotAccepted = "Please accept our terms"
        static let username = "The username must be at least 6 characters long and may not contains a \"p\". It must contain either an \"a\" or a \"b\"."
        static let website = "Not a valid website."
        static let password = "Use at least 8 characters."
        static let repeatPassword = "Must match Password."
        
        static let empty = "Password cannot be empty."
        static let noLetter = "Must contain at least one letter."
        static let noNumber = "Must contain at least one number."
        static let minLengthOf8 = "Must be at least 8 characters long."
        static let containsY = "Please dont use the letter \"y\"."
    }
}
