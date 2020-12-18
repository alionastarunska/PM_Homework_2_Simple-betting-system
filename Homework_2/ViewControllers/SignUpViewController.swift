//
//  SignUpViewController.swift
//  Homework_2
//
//  Created by Aliona Starunska on 16.12.2020.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet private weak var roleSegment: UISegmentedControl!
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmTextField: UITextField!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func signUpAction(_ sender: Any) {
        let role = User.Role(rawValue: roleSegment.selectedSegmentIndex) ?? User.Role.regular
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirm = confirmTextField.text ?? ""
        if let error = BettingSystem.shared.signUp(login: login, password: password, confirm: confirm, role: role) {
            errorMessageLabel.text = error
            errorMessageLabel.isHidden = false
        } else {
            if role == .regular {
                performSegue(withIdentifier: "registerUser", sender: nil)
            } else {
                performSegue(withIdentifier: "registerAdmin", sender: nil)
            }
        }
    }
    
    @IBAction private func loginAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
