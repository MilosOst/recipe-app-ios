//
//  SplashScreenView.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("splashScreen")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 12) {
                    Text("Get Inspired, Get Cooking")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Medium", size: 32).bold())
                    
                    Spacer()
                    
                    loginButton
                    
                    signUpButton
                }
                .frame(maxWidth: .infinity)
                .padding(16)
                .padding(.vertical, 24)
                .layoutPriority(2)
            }
        }
    }
    
    private var loginButton: some View {
        NavigationLink(destination: LoginView()) {
            Text("Log In")
                .frame(maxWidth: .infinity)
                .font(.custom("Poppins-Medium", size: 22))
                .foregroundColor(.white)
                .padding()
                .background(Color.brightGreen)
                .cornerRadius(16)
                .accessibilityAddTraits([.isButton])
        }
    }
    
    private var signUpButton: some View {
        NavigationLink(destination: SignUpView()) {
            Text("Sign Up")
                .frame(maxWidth: .infinity)
                .font(.custom("Poppins-Medium", size: 22))
                .foregroundColor(.white)
                .padding()
                .background(.black.opacity(0.7))
                .cornerRadius(16)
                .accessibilityAddTraits([.isButton])
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SplashScreenView()
                .preferredColorScheme(.light)
            
            SplashScreenView()
                .preferredColorScheme(.dark)
        }
    }
}
