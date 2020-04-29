//
//  ValidationStrategy.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation

public enum ValidationStrategy {
    /// only when all rules are valid == .valid
    case required
    /// also valid if notValidated, only .notValid if rules are notValid
    case optional
}
