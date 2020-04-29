//
//  ValidationFormatter.swift
//  Validated
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import Foundation

public struct ValidationFormatter<Value: Validatable> {
    let formatter: ((Value) -> Value)
    
    internal init(_ formatter: @escaping ((Value) -> Value)) {
        self.formatter = formatter
    }
}
