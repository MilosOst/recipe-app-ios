//
//  RecipeSubmission.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import Foundation

struct RecipeSubmission: Encodable {
    var name: String = ""
    var coverPhoto: String = ""
    var categories = Set<RecipeCategory>()
    var minutesToMake: Int = 0
    var ingredients = [RecipeIngredient]()
    var description = ""
    var steps = [RecipeStep]()
    
    var isValid: Bool {
        !(name.isEmpty || coverPhoto.isEmpty || ingredients.count == 0 || minutesToMake < 0 || steps.count == 0)
    }
    
    mutating func reset() {
        name = ""
        coverPhoto = ""
        categories = []
        minutesToMake = 0
        ingredients = []
        description = ""
        steps = []
    }
}

extension RecipeSubmission {
    static let example = RecipeSubmission(name: "Pizza", coverPhoto: "", categories: [.lunch], minutesToMake: 60, ingredients: [RecipeIngredient(name: "Cheese", quantity: 100, unit: .g)], description: "Greatest Pizza Recipe on Earth.", steps: [.init(content: "Place the pizza in the oven")])
}
