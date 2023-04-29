//
//  LoginViewModel.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import Foundation

struct LoginCredentials: Codable {
    var usernameOrEmail = ""
    var password = ""
    
}

@MainActor
class LoginViewModel: ObservableObject {
    @Published var credentials = LoginCredentials()
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    var loginDisabled: Bool {
        credentials.usernameOrEmail.isEmpty || credentials.password.isEmpty
    }
    
    /// Attempt to login with the current credentials.
    /// - Returns: Boolean indicating whether login was successful
    func attemptLogin() async -> Bool {
        isLoading = true
        errorMessage = nil
        
        do {
            try await APIService.shared.login(credentials)
            isLoading = false
            return true
        } catch APIError.unauthorized {
            errorMessage = "Invalid login credentials"
        } catch APIError.httpStatusCodeFailed(let err) {
            errorMessage = err.message
        } catch {
            errorMessage = "Sorry there was an issue with your login."
        }
        
        isLoading = false
        return false
    }
}
