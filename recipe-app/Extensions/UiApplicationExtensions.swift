//
//  UiApplicationExtensions.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
