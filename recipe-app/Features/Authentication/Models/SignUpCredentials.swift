//
//  SignUpCredentials.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import Foundation

struct SignUpCredentials: Encodable {
    var email = ""
    var username = ""
    var password = ""
    var passwordConfirmation = ""
    
    var isEmpty: Bool {
        email.isEmpty || username.isEmpty || password.isEmpty || passwordConfirmation.isEmpty
    }
    
    var passwordMismatch: Bool {
        password != passwordConfirmation
    }
}
