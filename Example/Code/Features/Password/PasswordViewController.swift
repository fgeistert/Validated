//
//  PasswordViewController.swift
//  Example
//
//  Created by Fabian Geistert on 29.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import UIKit
import Validated
import Combine

class PasswordViewController: UIViewController {
    
    // MARK: - Create
    
    var viewModel: PasswordViewModel!
    var onFinished: (() -> Void)?
    
    static func create() -> PasswordViewController {
        let viewController = PasswordViewController()
        viewController.viewModel = PasswordViewModel()
        return viewController
    }
    
    // MARK: - Views
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(validLabel)
        
        return stackView
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        return textField
    }()
    
    lazy var validLabel: UILabel = {
        let label = UILabel()
        label.text = "❌"
        return label
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .red
        label.text = Strings.FormErrors.generic
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4
        button.titleEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.addTarget(self, action: #selector(onButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        setupTextPublisher()
        setupBindings()
    }
    
    fileprivate func setupBindings() {
        viewModel.$password
            .dropFirst()
            .sink { [weak self] (result) in
                self?.setErrorMessage(from: result)
                
                switch result {
                case .valid(let value):
                    self?.validLabel.text = "✅"
                    print("💩new password: valid -> \(value ?? "nil")")
                case .notValid:
                    self?.validLabel.text = "❌"
                    print("💩new password: notValid")
                }
            }
            .store(in: &cancellables)

        viewModel.isValid
            .sink { [weak self] (isValid) in
                print("✅isFormValid?: \(isValid)")
                self?.setButton(isValid: isValid)
            }
            .store(in: &cancellables)
    }
    
    fileprivate func setupTextPublisher() {
        // bind values of textfield to our @Validated object
        
        textField
            .textPublisher
            .assign(to: \.password, on: viewModel) // warning: strong reference!!
            .store(in: &cancellables)
    }
    
    // MARK: - Actions
    
    @objc private func onButtonPressed() {
        onFinished?()
    }
    
    // MARK: - Setup & UI
    
    fileprivate func setupUI() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(horizontalStackView)
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(button)
        
        title = "Password"
        view.backgroundColor = .white
    }
    
    fileprivate func setupConstraints() {
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
    }
    
    private func setButton(isValid: Bool) {
        button.isEnabled = isValid
        button.backgroundColor = isValid ? UIColor.blue : UIColor.blue.withAlphaComponent(0.5)
    }
    
    // should be moved to viewModel -> errorText Publisher
    private func setErrorMessage(from result: ValidationResult<String>) {
        switch result {
        case .valid:
            errorLabel.isHidden = true
        case .notValid:
            errorLabel.isHidden = false
            
            // dynamic error message
            guard let value = viewModel.password else {
                errorLabel.text = Strings.FormErrors.empty
                return
            }
            
            if !ValidationResult.validate(value, with: .containsLetter).isValid {
                errorLabel.text = Strings.FormErrors.noLetter
            } else if !ValidationResult.validate(value, with: .containsNumber).isValid {
                errorLabel.text = Strings.FormErrors.noNumber
            } else if !ValidationResult.validate(value, with: .minLength(8)).isValid {
                errorLabel.text = Strings.FormErrors.minLengthOf8
            } else if ValidationResult.validate(value, with: .contains("y")).isValid {
                errorLabel.text = Strings.FormErrors.containsY
            }
        }
    }
}
