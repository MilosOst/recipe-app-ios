//
//  NoAutoCompleteModifier.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

struct NoAutoCompleteModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .keyboardType(.alphabet)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
    }
}
