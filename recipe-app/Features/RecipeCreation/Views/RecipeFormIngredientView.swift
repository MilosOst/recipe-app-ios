//
//  RecipeFormIngredientView.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

struct RecipeFormIngredientView: View {
    @Binding var ingredient: RecipeIngredient
    
    private let quantityFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.zeroSymbol = ""
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Ingredient Name", text: $ingredient.name)
                .font(.custom("Poppins-Medium", size: 16))
            
            HStack {
                TextField("Quantity", value: $ingredient.quantity, formatter: quantityFormatter)
                    .frame(maxWidth: 70)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .font(.custom("Poppins-Light", size: 14))
                    .overlay(
                        VStack {
                            Divider()
                                .foregroundColor(.primary)
                                .offset(x: 0, y: 16)
                        }
                    )
                
                Picker("", selection: $ingredient.unit) {
                    ForEach(IngredientUnit.allCases) { unit in
                        Text(String(describing: unit))
                            .tag(unit)
                    }
                }
                .frame(maxWidth: 90)
                
                Spacer()
            }
            
            Divider()
        }
        .frame(maxWidth: .infinity)
        .listRowSeparator(.hidden)
        .padding(4)
    }
}

struct RecipeFormIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFormIngredientView(ingredient: .constant(.init()))
    }
}
