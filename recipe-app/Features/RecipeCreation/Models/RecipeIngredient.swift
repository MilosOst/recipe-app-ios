//
//  RecipeIngredient.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import Foundation

enum IngredientUnit: String, Codable, CaseIterable, Identifiable {
    case g
    case kg
    case oz
    case lb
    case mL
    case L
    case tbsp
    case tsp
    
    var id: String {
        switch self {
        case .g:
            return "g"
        case .kg:
            return "kg"
        case .oz:
            return "oz"
        case .lb:
            return "lb"
        case .mL:
            return "mL"
        case .L:
            return "L"
        case .tbsp:
            return "tbsp"
        case .tsp:
            return "tsp"
        }
    }
}

struct RecipeIngredient: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case name
        case quantity
        case unit
    }
    
    var name: String = ""
    var quantity: Double = 0
    var unit: IngredientUnit = .g
    let id = UUID()
}
