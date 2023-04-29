//
//  FormField.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

struct FormField<V>: View where V: ViewModifier {
    enum FieldType {
        case regular
        case secure
    }
    
    let sysImage: String
    let fieldName: String
    @Binding private var binding: String
    private let viewModifier: V
    private let fieldType: FieldType
    let errorMessage: String?
    
    init(image: String, fieldName: String, binding: Binding<String>, vm: V = EmptyModifier(), type: FieldType = .regular, errorMessage: String? = nil) {
        self.sysImage = image
        self.fieldName = fieldName
        self._binding = binding
        self.viewModifier = vm
        self.fieldType = type
        self.errorMessage = errorMessage
    }
    
    var body: some View {
        Section {
            HStack {
                Image(systemName: sysImage)
                    .frame(width: 42, height: 42)
                    .foregroundColor(.gray)
                    .padding(10)
                
                if fieldType == .secure {
                    SecureField(fieldName, text: $binding)
                        .modifier(viewModifier)
                } else {
                    TextField(fieldName, text: $binding)
                        .modifier(viewModifier)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.secondary, lineWidth: 1)
            )
        } footer: {
            if let msg = errorMessage {
                Text(msg)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .fixedSize(horizontal: true, vertical: false)
            }
        }
    }
}

//struct FormField_Previews: PreviewProvider {
//    static var previews: some View {
//        FormField()
//    }
//}
