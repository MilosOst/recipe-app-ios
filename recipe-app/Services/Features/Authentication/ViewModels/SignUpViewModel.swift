//
//  SignUpViewModel.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

@MainActor
class SignUpViewModel: ObservableObject {
    @Published var credentials = SignUpCredentials()
    @Published var isLoading = false
    @Published var formErrors = [String: String]()
    @Published var errorMessage: String? = nil
    @Published private(set) var registered = false
    
    var isSubmissionDisabled: Bool {
        credentials.isEmpty || credentials.passwordMismatch
    }
    
    func signUp() async {
        if isLoading { return }
        
        isLoading = true
        formErrors = [:]
        errorMessage = nil
        
        do {
            try await APIService.shared.register(credentials)
            withAnimation {
                registered = true
            }
        } catch APIError.badRequest(let validationErrors) {
            formErrors = Dictionary(validationErrors.map { ($0.param, $0.message) } ) { _, last in last }
        } catch APIError.conflict(let errors) {
            formErrors = Dictionary(errors.map { ($0.param, $0.message) } ) { _, last in last }
        }
        catch APIError.httpStatusCodeFailed(let err) {
            errorMessage = err.message
        } catch {
            errorMessage = "Sorry, there was an issue with your registration."
        }
        
        isLoading = false
    }
}
