//
//  RecipeStep.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import Foundation

struct RecipeStep: Encodable, Identifiable {
    var content: String
    let id = UUID()
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(content)
    }
}
