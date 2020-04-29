//
//  RegisterViewController.swift
//  Example
//
//  Created by Fabian Geistert on 28.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import UIKit
import Validated
import Combine

class RegisterViewController: UIViewController {
    
    // MARK: - Create
    
    var viewModel: RegisterViewModel!
    var onFinished: (() -> Void)?
    
    static func create() -> RegisterViewController {
        let viewController = RegisterViewController()
        viewController.viewModel = RegisterViewModel()
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
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Username"
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "E-Mail"
        return textField
    }()
    
    lazy var websiteTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Website (Optional)"
        return textField
    }()
    
    lazy var websiteErrorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .red
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        return textField
    }()
    
    lazy var passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .red
        return label
    }()
    
    lazy var repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Repeat Password"
        return textField
    }()
    
    lazy var repeatPasswordErrorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .red
        return label
    }()
    
    lazy var toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(switchDidChange), for: .touchUpInside)
        return toggle
    }()
    
    lazy var textFieldErrorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()
    
    lazy var toggleErrorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .red
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
        viewModel.$userName
            .bindValidationStateTo(view: textFieldErrorLabel, with: Strings.FormErrors.username)
            .sink { (result) in
                switch result {
                case .valid(let value):
                    print("💩new terms: valid -> \(value ?? "nil")")
                case .notValid:
                    print("💩new terms: notValid")
                }
            }
            .store(in: &cancellables)
        
        viewModel.$email
            //            .bindValidationStateTo(view: textFieldErrorLabel, with: Date().description) // error: NOT dynamic
            .sink { (result) in
                print("👍new email: \(result) -> \(result.value ?? "nil")")
            }
            .store(in: &cancellables)
        
        viewModel.$website
            .bindValidationStateTo(view: websiteErrorLabel, with: Strings.FormErrors.website)
            .sink { (result) in
                print("💩new website: \(result) -> \(result.value ?? "nil")")
            }
            .store(in: &cancellables)
        
        viewModel.$password
            .bindValidationStateTo(view: passwordErrorLabel, with: Strings.FormErrors.password)
            .sink { (result) in
                print("💩new password: \(result) -> \(result.value ?? "nil")")
            }
            .store(in: &cancellables)
        
        viewModel.repeatPassword.projectedValue
            .bindValidationStateTo(view: repeatPasswordErrorLabel, with: Strings.FormErrors.repeatPassword)
            .sink { (result) in
                print("💩new repeatPassword: \(result) -> \(result.value ?? "nil")")
            }
            .store(in: &cancellables)
        
        viewModel.$termsAccepted
            //            .bindValidationStateTo(view: toggleErrorLabel)
            .bindValidationStateTo(view: toggleErrorLabel, with: Strings.FormErrors.termsNotAccepted)
            .sink { (result) in
                print("💩new terms: \(result) -> \(result.value ?? false)")
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
            .assign(to: \.userName, on: viewModel) // warning: strong reference!!
            .store(in: &cancellables)
        
        emailTextField
            .textPublisher
            .assign(to: \.email, on: viewModel) // warning: strong reference!!
            .store(in: &cancellables)
        
        websiteTextField
            .textPublisher
            .assign(to: \.website, on: viewModel) // warning: strong reference!!
            .store(in: &cancellables)
        
        passwordTextField
            .textPublisher
            .assign(to: \.password, on: viewModel) // warning: strong reference!!
            .store(in: &cancellables)
        
        repeatPasswordTextField
            .textPublisher
            .assign(to: \.repeatPassword.wrappedValue, on: viewModel) // warning: strong reference!!
            .store(in: &cancellables)
    }
    
    // MARK: - Actions
    
    @objc fileprivate func switchDidChange(sender: UISwitch?) {
        viewModel.termsAccepted = toggle.isOn
    }
    
    @objc private func onButtonPressed() {
        onFinished?()
    }
    
    // MARK: - Setup & UI
    
    fileprivate func setupUI() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(textFieldErrorLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(websiteTextField)
        stackView.addArrangedSubview(websiteErrorLabel)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordErrorLabel)
        stackView.addArrangedSubview(repeatPasswordTextField)
        stackView.addArrangedSubview(repeatPasswordErrorLabel)
        stackView.addArrangedSubview(toggle)
        stackView.addArrangedSubview(toggleErrorLabel)
        stackView.addArrangedSubview(button)
        
        title = "Register"
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
}
