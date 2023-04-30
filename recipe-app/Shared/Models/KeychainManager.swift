//
//  KeychainManager.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import Foundation
import Security

final class KeychainManager {
    enum KeychainError: Error {
        case unknown(OSStatus)
    }
    
    static let standard = KeychainManager()
    private init() { }
    
    func saveToken(_ token: String) throws {
        let query = [
            kSecValueData: token.data(using: .utf8) ?? Data(),
            kSecAttrService: "access-token",
            kSecAttrAccount: "recipeRealm",
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        if status == errSecDuplicateItem { // Replace old token
            let query = [
                kSecAttrService: "access-token",
                kSecAttrAccount: "recipeRealm",
                kSecClass: kSecClassGenericPassword
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: token.data(using: .utf8)] as CFDictionary
            SecItemUpdate(query, attributesToUpdate)
            return
        }
        
        if status != errSecSuccess {
            throw KeychainError.unknown(status)
        }
    }
    
    func getToken() -> String? {
        let query = [
            kSecAttrService: "access-token",
            kSecAttrAccount: "recipeRealm",
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        if let data = result as? Data {
            return String(data: data, encoding: .utf8) ?? nil
        }
        
        return nil
    }
    
    func deleteToken() {
        let query = [
            kSecAttrAccount: "recipeRealm",
            kSecAttrService: "access-token",
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        SecItemDelete(query)
    }
}
