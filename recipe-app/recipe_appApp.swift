//
//  recipe_appApp.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

@main
struct recipe_appApp: App {
    @StateObject private var auth = Authentication()
    @StateObject private var account = AccountInfo()
    @State private var isLoading = true
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isLoading {
                    // TODO: Add Loading Screen
                    Image("splashScreen")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                } else {
                    if auth.isValidated {
                        ContentView()
                            .environmentObject(auth)
                    } else {
                        SplashScreenView()
                            .environmentObject(auth)
                    }
                }
            }
            .task {
                await attemptPersistentLogin()
            }
        }
    }
    
    private func attemptPersistentLogin() async {
        do {
            account.updateAccountInfo(from: try await APIService.shared.getMe())
            withAnimation {
                auth.updateValidation(success: true)
            }
        } catch {
            
        }
        
        isLoading = false
    }
}
