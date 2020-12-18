//
//  User.swift
//  Homework_2
//
//  Created by Aliona Starunska on 14.12.2020.
//

import Foundation

struct User {
    var role: Role
    var status: Status
    var login: String
    var password: String
    
    // MARK: - Enums
    enum Role: Int {
        case regular
        case admin
    }
    
    enum Status: Int {
        case normal
        case banned
    }
    
    var dictionary: [String: Any] {
        return ["role": role.rawValue, "status": status.rawValue, "login": login, "password": password]
    }
    
    init(dictionary: [String: Any]) {
        let role = Role(rawValue: dictionary["role"] as? Int ?? 0) ?? .regular
        let status = Status(rawValue: dictionary["status"] as? Int ?? 0) ?? .normal
        let login = dictionary["login"] as? String ?? ""
        let password = dictionary["password"] as? String ?? ""
        self.init(role: role, status: status, login: login, password: password)
    }
    
    init(role: Role, status: Status, login: String, password: String) {
        self.role = role
        self.status = status
        self.login = login
        self.password = password
    }
}
