//
//  APIService.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = "http://192.168.50.75:3000"
    
    private init() {}
    
    private var token: String {
        return ""
    }
    
    private func validateHTTPResponse(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidURL
        }
        
        switch httpResponse.statusCode {
        case 400:
            let errors = (try JSONDecoder().decode(APIValidationErrorResponse.self, from: data)).errors
            throw APIError.badRequest(errors: errors)
        case 401:
            throw APIError.unauthorized
        case 404:
            throw APIError.notFound
        case 402...599:
            let error = try JSONDecoder().decode(APIErrorMessage.self, from: data)
            throw APIError.httpStatusCodeFailed(error: error)
        default:
            return
        }
    }
    
    func login(_ credentials: LoginCredentials) async throws {
        guard let url = URL(string: "\(baseURL)/auth/login") else {
            throw APIError.invalidURL
        }
        
        var req = URLRequest(url: url)
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpMethod = "POST"
        let encoded = try JSONEncoder().encode(credentials)
        
        let (data, response) = try await URLSession.shared.upload(for: req, from: encoded)
        try validateHTTPResponse(data: data, response: response)
        let jwtToken = try JSONDecoder().decode(String.self, from: data)
        
        try KeychainManager.standard.saveToken(jwtToken)
        
        return
    }
}
