//
//  DataExtensions.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
