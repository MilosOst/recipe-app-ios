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
    
    var body: some Scene {
        WindowGroup {
            Group {
                if auth.isValidated {
                    ContentView()
                        .environmentObject(auth)
                } else {
                    SplashScreenView()
                        .environmentObject(auth)
                }
            }
        }
    }
}
