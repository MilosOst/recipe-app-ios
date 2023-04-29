//
//  Authentication.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

@MainActor
class Authentication: ObservableObject {
    @Published private(set) var isValidated = false
    
    func updateValidation(success: Bool) {
        isValidated = success
    }
}
