//
//  SearchbarView.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

struct SearchbarView: View {
    @Binding var query: String
    let prompt: String
    let systemImage: String
    
    init(query: Binding<String>, prompt: String, systemImage: String = "magnifyingglass") {
        self._query = query
        self.prompt = prompt
        self.systemImage = systemImage
    }
    
    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .foregroundColor(query.isEmpty ? .secondary : .primary)
            
            TextField(prompt, text: $query)
                .foregroundColor(.primary)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .foregroundColor(.secondary)
                        .accessibilityAddTraits(.isButton)
                        .opacity(query.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            query = ""
                        },
                    alignment: .trailing
                )
                .submitLabel(.search)
        }
        .font(.headline)
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(uiColor: .systemBackground))
                .shadow(
                    color: .primary.opacity(0.15),
                    radius: 10, x: 0, y: 0
                )
        )
    }
}

struct SearchbarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchbarView(query: .constant("Pizza"), prompt: "Search any recipes")
                .preferredColorScheme(.light)
            
            SearchbarView(query: .constant("Pizza"), prompt: "Search any recipes")
                .preferredColorScheme(.dark)
        }
    }
}
