//
//  LoginView.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var vm = LoginViewModel()
    @EnvironmentObject var auth: Authentication
    
    var body: some View {
        VStack(spacing: 16) {
            FormField(image: "person", fieldName: "Email/Username", binding: $vm.credentials.usernameOrEmail)
            
            FormField(image: "key", fieldName: "password", binding: $vm.credentials.password, type: .secure)
            
            if let msg = vm.errorMessage {
                Text(msg)
                    .foregroundColor(.red)
                    .font(.custom("Poppins-Light", size: 14))
                    .fixedSize(horizontal: true, vertical: false)
            }
            
            FormButton(text: "Log In", disabled: vm.loginDisabled, pendingResponse: vm.isLoading, onSubmit: login)
        }
        .padding()
        .allowsHitTesting(!vm.isLoading)
        .navigationTitle("Log In")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func login() async {
        if (await vm.attemptLogin()) {
            withAnimation {
                auth.updateValidation(success: true)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                .preferredColorScheme(.light)
            
            LoginView()
                .preferredColorScheme(.dark)
        }
    }
}
