//
//  FormButton.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

struct FormButton: View {
    let text: String
    let disabled: Bool
    let pendingResponse: Bool
    let onSubmit: (() async -> Void)
    
    var body: some View {
        Button {
            Task {
                await onSubmit()
            }
        } label: {
            if pendingResponse {
                ProgressView()
            } else {
                Text(text)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .clipShape(
            Capsule()
        )
        .padding()
        .background(.blue.opacity(disabled ? 0.4 : 1))
        .cornerRadius(12)
        .disabled(disabled)
    }
}
