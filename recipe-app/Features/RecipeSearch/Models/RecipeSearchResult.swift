//
//  RecipeSearchResult.swift
//  recipe-app
//
//  Created by Milos on 2023-04-30.
//

import Foundation

struct UserInfo: Codable {
    let _id: String
    let username: String
}

struct RecipeSearchResult: Identifiable, Decodable {
    let _id: String
    let user: UserInfo
    let name: String
    let coverPhoto: String
    let description: String
    let ingredients: [RecipeIngredient]
    let categories: [RecipeCategory]
    let minutesToMake: Int
    let steps: [String]
    let ratingsTotal: Int
    let ratingsCount: Int
    let datePosted: Date
    
    var id: String {
        _id
    }
}
