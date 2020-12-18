//
//  AddBetViewController.swift
//  Homework_2
//
//  Created by Aliona Starunska on 17.12.2020.
//

import UIKit

class AddBetViewController: UIViewController {

    @IBOutlet private weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    @IBAction private func addAction(_ sender: Any) {
        guard !textView.text.isEmpty else { return }
        BettingSystem.shared.makeBet(textView.text)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        textView.resignFirstResponder()
    }
}
