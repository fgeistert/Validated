//
//  LoginViewController.swift
//  Example
//
//  Created by Fabian Geistert on 29.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import UIKit
import Validated
import Combine

class LoginViewController: UIViewController {
    
    // MARK: - Create
    
    var viewModel: LoginViewModel!
    var onFinished: (() -> Void)?
    
    static func create() -> LoginViewController {
        let viewController = LoginViewController()
        viewController.viewModel = LoginViewModel()
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
    
    lazy var emailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(emailValidLabel)
        
        return stackView
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email"
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return textField
    }()
    
    lazy var emailValidLabel: UILabel = {
        let label = UILabel()
        label.text = "❌"
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    lazy var emailErrorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .red
        label.text = Strings.FormErrors.empty
        return label
    }()
    
    lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordValidLabel)
        
        return stackView
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return textField
    }()
    
    lazy var passwordValidLabel: UILabel = {
        let label = UILabel()
        label.text = "❌"
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    lazy var passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .red
        label.text = Strings.FormErrors.empty
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
        viewModel.$email
            .bindValidationStateTo(view: emailErrorLabel)
            .sink { [weak self] (result) in
                switch result {
                case .valid(let value):
                    self?.emailValidLabel.text = "✅"
                    print("new email: valid -> \(value ?? "nil")")
                case .notValid:
                    self?.emailValidLabel.text = "❌"
                    print("new email: notValid")
                }
            }
            .store(in: &cancellables)
        
        viewModel.$password
            .bindValidationStateTo(view: passwordErrorLabel)
            .sink { [weak self] (result) in
                switch result {
                case .valid(let value):
                    self?.passwordValidLabel.text = "✅"
                    print("new password: valid -> \(value ?? "nil")")
                case .notValid:
                    self?.passwordValidLabel.text = "❌"
                    print("new password: notValid")
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
        
        emailTextField
            .textPublisher
            .assign(to: \.email, on: viewModel) // warning: strong reference!!
            .store(in: &cancellables)
        
        passwordTextField
            .textPublisher
            .assign(to: \.password, on: viewModel) // warning: strong reference!!
            .store(in: &cancellables)
    }
    
    // MARK: - Actions
    
    @objc private func onButtonPressed() {
        // now safely access formatted fields
        guard let email = viewModel.email, let password = viewModel.password else { return }
        print("Finished! Email: \(email), Password: \(password)")
        onFinished?()
    }
    
    // MARK: - Setup & UI
    
    fileprivate func setupUI() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(emailStackView)
        stackView.addArrangedSubview(emailErrorLabel)
        stackView.addArrangedSubview(passwordStackView)
        stackView.addArrangedSubview(passwordErrorLabel)
        stackView.addArrangedSubview(button)
        
        title = "Login"
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
