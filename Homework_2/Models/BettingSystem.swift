//
//  BettingSystem.swift
//  Homework_2
//
//  Created by Aliona Starunska on 14.12.2020.
//

import Foundation

class BettingSystem {
    
    // MARK: - Singleton
    static let shared = BettingSystem()
    private init() {
        users = UserDefaults.standard.array(forKey: "users")?.compactMap({ User(dictionary: $0 as? [String: Any] ?? [:]) }) ?? []
        bets = UserDefaults.standard.array(forKey: "bets")?.compactMap({ Bet(dictionary: $0 as? [String: Any] ?? [:]) }) ?? []
    }
    
    // MARK: - Private
    private var users: [User] {
        didSet {
            UserDefaults.standard.set(users.map({ $0.dictionary }), forKey: "users")
        }
    }
    private var currentUser: User?
    private var bets: [Bet] {
        didSet {
            UserDefaults.standard.set(bets.map({ $0.dictionary }), forKey: "bets")
        }
    }
    
    // MARK: - Public
    
    func signUp(login: String, password: String, confirm: String, role: User.Role) -> String? {
        if login.isEmpty{
            return "Login can`t be empty!"
        } else if password.isEmpty{
            return "Password can`t be empty!"
        } else if password != confirm {
            return "Password and confirmation should match!"
        } else if users.first(where: { $0.login == login }) != nil {
            return "Login is already taken, please chouse different one!"
        } else {
            let user = User(role: role, status: .normal, login: login, password: password)
            users.append(user)
            currentUser = user
            return nil
        }
    }
    
    func login(login: String, password: String) -> (user: User?, error: String?) {
        if login.isEmpty{
            return (nil, "Login can`t be empty!")
        } else if password.isEmpty{
            return (nil, "Password can`t be empty!")
        } else if let user = users.first(where: { $0.login == login }) {
            if user.password != password {
                return (nil, "Invalid credentials")
            } else if user.status == .banned {
                return (nil, "You are banned!")
            } else {
                currentUser = user
                return (user, nil)
            }
        } else {
            return (nil, "User with this login is not registered yet")
        }
    }
    
    func getUsers() -> [User] {
        guard let currentUser = currentUser, currentUser.role == .admin else { return [] }
        return users.filter({ $0.role == .regular }).sorted { (u1, u2) -> Bool in
            if u1.role == u2.role {
                return u1.login > u2.login
            } else {
                return u1.status == .normal
            }
        }
    }
    
    func getBets() -> [Bet] {
        guard let currentUser = currentUser else { return [] }
        return bets.filter({ $0.userID == currentUser.login })
    }
    
    func makeBet(_ bet: String) {
        guard let currentUser = currentUser else { return }
        let bet = Bet(userID: currentUser.login, value: bet)
        bets.append(bet)
    }
    
    func ban(user: User) {
        guard let currentUser = currentUser,
              currentUser.role == .admin,
              let index = users.firstIndex(where: { $0.login == user.login }) else {
            return
        }
        users[index].status = .banned
    }
    
    func unban(user: User) {
        guard let currentUser = currentUser,
              currentUser.role == .admin,
              let index = users.firstIndex(where: { $0.login == user.login }) else {
            return
        }
        users[index].status = .normal
    }
    
    func logout() {
        currentUser = nil
    }
}
