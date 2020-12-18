//
//  BetsViewController.swift
//  Homework_2
//
//  Created by Aliona Starunska on 17.12.2020.
//

import UIKit

class BetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet private weak var tableView: UITableView!
    
    private var bets: [Bet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bets = BettingSystem.shared.getBets()
        tableView.reloadData()
    }
    
    @IBAction private func logoutAction(_ sender: Any) {
        BettingSystem.shared.logout()
        if let signUpViewController = presentingViewController as? SignUpViewController {
            dismiss(animated: true) {
                signUpViewController.dismiss(animated: true, completion: nil)
            }
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont(name: "Avenir-medium", size: 17)
        cell.clipsToBounds = true
        cell.cornerRadius = 7
        cell.selectionStyle = .none
        cell.textLabel?.text = bets[indexPath.row].value
        return cell
    }
}
