//
//  UITextField+TextPublisher.swift
//  Example
//
//  Created by Fabian Geistert on 28.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

#if canImport(Combine)
import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .filter { $0 == self }
            .map { $0.text }
            .eraseToAnyPublisher()
    }
}

#endif
