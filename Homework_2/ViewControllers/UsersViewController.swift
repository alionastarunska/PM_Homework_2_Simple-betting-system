//
//  UsersViewController.swift
//  Homework_2
//
//  Created by Aliona Starunska on 17.12.2020.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet private weak var tableView: UITableView!
    
    private var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        users = BettingSystem.shared.getUsers()
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
        return users.count
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
        let user = users[indexPath.row]
        cell.textLabel?.text = user.login + (user.status == .banned ? "(BANNED)" : "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let user = users[indexPath.row]
        let ban = UITableViewRowAction(style: .destructive, title: user.status == .normal ? "BAN" : "UNBAN") { (_, index) in
            user.status == .banned ? BettingSystem.shared.unban(user: user) : BettingSystem.shared.ban(user: user)
            self.users = BettingSystem.shared.getUsers()
            tableView.reloadData()
        }
        return [ban]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        BettingSystem.shared.ban(user: user)
        users = BettingSystem.shared.getUsers()
        tableView.reloadData()
    }
}
