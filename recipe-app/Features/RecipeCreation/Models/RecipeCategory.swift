//
//  RecipeCategory.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import Foundation

enum RecipeCategory: String, Codable, CaseIterable, Identifiable, Hashable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case dessert = "Dessert"
    case soup = "Soup"
    case salad = "Salad"
    case appetizer = "Appetizer"
    
    var id: String {
        switch self {
        case .breakfast:
            return "1"
        case .lunch:
            return "2"
        case .dinner:
            return "3"
        case .dessert:
            return "4"
        case .soup:
            return "5"
        case .salad:
            return "6"
        case .appetizer:
            return "7"
        }
    }
    
    var emoji: String {
        switch self {
        case .breakfast:
            return "🥞"
        case .lunch:
            return "🥞"
        case .dinner:
            return "🥞"
        case .dessert:
            return "🥞"
        case .soup:
            return "🥞"
        case .salad:
            return "🥞"
        case .appetizer:
            return "🥞"
        }
    }
}
