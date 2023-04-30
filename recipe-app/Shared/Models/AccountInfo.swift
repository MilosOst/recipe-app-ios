//
//  AccountInfo.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import Foundation

class AccountInfo: ObservableObject, Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username
        case email
        case profilePicURL
    }
    
    var id: String = ""
    var username: String = ""
    var email: String = ""
    var profilePicURL: String?
    
    func updateAccountInfo(from: AccountInfo) {
        id = from.id
        username = from.username
        email = from.email
        profilePicURL = from.profilePicURL
    }
    
    func reset() {
        id = ""
        username = ""
        email = ""
        profilePicURL = nil
    }
}
