//
//  ContentView.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            RecipeSearchRootView()
                .tag(1)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            RecipeFormView()
                .tag(2)
                .tabItem {
                    Label("Create", systemImage: "plus")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AccountInfo())
    }
}
