//
//  RecipeSearchRootView.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

struct RecipeSearchRootView: View {
    @EnvironmentObject var account: AccountInfo
    @State private var query = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Hello \(account.username)")
                            .font(.custom("Poppins-Light", size: 14))
                        
                        Text("What would you like to cook today?")
                            .font(.custom("Poppins-Medium", size: 18))
                        
                        SearchbarView(query: $query, prompt: "Search any recipes")
                    }
                    
                    categories
                }
            }
            .padding()
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await search()
            }
        }
    }
    
    private var categories: some View {
        VStack(alignment: .leading) {
            Text("Categories")
                .font(.custom("Poppins-Medium", size: 16).bold())
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(RecipeCategory.allCases) { category in
                        Text(String(describing: category).capitalized)
                            .font(.custom("Poppins-Regular", size: 14))
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.brightGreen.opacity(0.8))
                            .cornerRadius(12)
                            .shadow(color: .secondary, radius: 1)
                    }
                }
            }
        }
        .padding()
    }
    
    func search() async {
        do {
            let results = try await APIService.shared.searchRecipes(name: "pizza")
            print(results)
        } catch {
            
        }
    }
}

struct RecipeSearchRootView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSearchRootView()
            .environmentObject(AccountInfo())
    }
}
