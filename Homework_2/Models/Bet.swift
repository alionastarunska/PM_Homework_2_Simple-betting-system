//
//  Bet.swift
//  Homework_2
//
//  Created by Aliona Starunska on 14.12.2020.
//

import Foundation

struct Bet {
    var userID: String
    var value: String
    
    var dictionary: [String: Any] {
        return ["userID": userID, "value": value]
    }
    init(dictionary: [String: Any]) {
        let userID = dictionary["userID"] as? String ?? ""
        let value = dictionary["value"] as? String ?? ""
        self.init(userID: userID, value: value)
    }
    init(userID: String, value: String) {
        self.userID = userID
        self.value = value
    }
}
