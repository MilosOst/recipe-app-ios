//
//  EmailModifier.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

struct EmailModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .keyboardType(.emailAddress)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
    }
}
