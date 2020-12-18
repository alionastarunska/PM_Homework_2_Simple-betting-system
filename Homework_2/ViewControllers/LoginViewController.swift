//
//  LoginViewController.swift
//  Homework_2
//
//  Created by Aliona Starunska on 15.12.2020.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginTextField.text = ""
        passwordTextField.text = ""
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustingHeight(true, notification: notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustingHeight(false, notification: notification)
    }
    
    func adjustingHeight(_ show: Bool, notification: Notification) {
        guard let userInfo = (notification as NSNotification).userInfo,
              let keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let animationDurarion = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.0
        let changeInHeight = show ? keyboardFrame.height : 0.0
        guard bottomConstraint.constant != changeInHeight else { return }
        bottomConstraint.constant = changeInHeight
        UIView.animate(withDuration: animationDurarion, animations: { [unowned self] () -> Void in
            self.view.layoutIfNeeded()
        })
    }

    @IBAction private func loginAction(_ sender: Any) {
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let result = BettingSystem.shared.login(login: login, password: password)
        if let error = result.error {
            errorMessageLabel.text = error
            errorMessageLabel.isHidden = false
        } else if let user = result.user {
            if user.role == .admin {
                performSegue(withIdentifier: "showUsers", sender: nil)
            } else {
                performSegue(withIdentifier: "showBets", sender: nil)
            }
        }
    }
}
