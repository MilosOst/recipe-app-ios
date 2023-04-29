//
//  APIError.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import Foundation

struct APIErrorMessage: Decodable {
    let message: String
}

enum APIError: Error, LocalizedError, Identifiable {
    case invalidURL
    case badRequest(errors: [APIValidationError])
    case unauthorized
    case notFound
    case httpStatusCodeFailed(error: APIErrorMessage)
    
    var id: String {
        self.localizedDescription
    }
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .badRequest( _):
            return "(400) - Bad Request"
        case .unauthorized:
            return "(401) - Unauthorized"
        case .notFound:
            return "(404) - Not Found"
        case .httpStatusCodeFailed(let error):
            return error.message
        }
    }
}
