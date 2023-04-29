//
//  APIValidationError.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import Foundation

struct APIValidationErrorResponse: Decodable {
    let errors: [APIValidationError]
}

struct APIValidationError: Decodable {
    let param: String
    let message: String
}
