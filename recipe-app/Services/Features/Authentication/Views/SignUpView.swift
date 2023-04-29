//
//  SignUpView.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var vm = SignUpViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            if vm.registered {
                successView
            } else {
                VStack(spacing: 16) {
                    VStack(spacing: 8) {
                        Text("RecipeRealm")
                            .font(.custom("Poppins-Regular", size: 24))
                        
                        Text("Find your new favourite recipe today.")
                            .font(.custom("Poppins-Light", size: 16))
                    }
                }
                
                Divider()
                
                FormField(image: "envelope", fieldName: "Email", binding: $vm.credentials.email, vm: EmailModifier(), errorMessage: vm.formErrors["email"])
                
                FormField(image: "person", fieldName: "Username", binding: $vm.credentials.username, vm: NoAutoCompleteModifier(), errorMessage: vm.formErrors["username"])
                
                FormField(image: "key", fieldName: "Password", binding: $vm.credentials.password, type: .secure, errorMessage: vm.formErrors["password"])
                
                FormField(image: "key", fieldName: "Confirm Password", binding: $vm.credentials.passwordConfirmation, type: .secure, errorMessage: vm.formErrors["passwordConfirmation"])
                
                Divider()
                
                Section {
                    FormButton(text: "Sign Up", disabled: vm.isSubmissionDisabled, pendingResponse: vm.isLoading, onSubmit: vm.signUp)
                } footer: {
                    if let msg = vm.errorMessage {
                        Text(msg)
                            .font(.custom("Poppins-Light", size: 12))
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .allowsHitTesting(!vm.isLoading)
        .padding()
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var successView: some View {
        VStack(spacing: 15) {
            Image(systemName: "checkmark")
                .foregroundColor(.green)
                .padding()
                .background(Color(red: 221/255, green: 1, blue: 236/255))
                .clipShape(Capsule())
            
            Text("Your registration was successful!")
                .font(.custom("Poppins-Medium", size: 20))
            
            Text("Log In")
                .frame(maxWidth: 200)
                .font(.custom("Poppins-Medium", size: 22))
                .foregroundColor(.white.opacity(0.9))
                .padding(.horizontal, 22)
                .padding(.vertical, 12)
                .background(.blue)
                .cornerRadius(16)
                .accessibilityAddTraits([.isButton])
                .onTapGesture {
                    dismiss()
                }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUpView()
                .preferredColorScheme(.light)
            
            SignUpView()
                .preferredColorScheme(.dark)
        }
    }
}
