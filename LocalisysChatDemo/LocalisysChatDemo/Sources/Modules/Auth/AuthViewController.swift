//
//  Auth.swift
//  LocalisysChatDemo
//
//  Created by Oleksii Pyvovarov on 7/6/17.
//  Copyright © 2017 Oleksii Pyvovarov. All rights reserved.
//

import UIKit
import FirebaseAuth

final class AuthViewController: UIViewController {

  // MARK: - UI

  @IBOutlet weak var loginTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var registerButton: UIButton!
  @IBOutlet var actionButtons: [UIButton]!

  // MARK: - Actions

  @IBAction func signIn(_ sender: Any) {
    Auth.auth().signIn(withEmail: loginTextField.text ?? "", password: passwordTextField.text ?? "") { (user, error) in
      print("Sign User result = \(user), error = \(error)")
    }
  }

  @IBAction func signUp(_ sender: Any) {
    guard let login = loginTextField.text, let password = passwordTextField.text else { return }
    Auth.auth().createUser(withEmail: login, password: password) { (user, error) in
      print("Create user, current status \(Auth.auth().isAuthenticated ? "Identified" : "Guest"), error = \(error)")
    }
  }
}


extension AuthViewController: UITextFieldDelegate {
  @IBAction func textFieldDidChange(_ textField: UITextField) {
    guard let login = loginTextField.text else { return }
    login.isEmail
      .ifFalse({ [weak self] in self?.actionButtons.forEach { $0.isEnabled = false } })
      .ifTrue({ [weak self] in
        self?.signInButton.isEnabled = true
        Auth.auth().fetchProviders(forEmail: login) { [weak self] (providers, error) in
          self?.registerButton.isEnabled = providers == nil
        }
      })
  }
}
















