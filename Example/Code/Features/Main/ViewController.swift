//
//  ViewController.swift
//  Example
//
//  Created by Fabian Geistert on 27.04.20.
//  Copyright © 2020 Fabian Geistert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        let viewController = LoginViewController.create()
        viewController.onFinished = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func passwordPressed(_ sender: Any) {
        let viewController = PasswordViewController.create()
        viewController.onFinished = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        let viewController = RegisterViewController.create()
        viewController.onFinished = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func noCombinePressed(_ sender: Any) {
        let viewController = NoCombineViewController.create()
        viewController.onFinished = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true, completion: nil)
    }
}
