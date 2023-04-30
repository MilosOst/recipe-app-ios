//
//  RecipeFormHeaderView.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

struct RecipeFormHeaderView: View {
    @State private var showingPhotoPicker = false
    @Binding var recipeName: String
    @Binding var coverImage: UIImage?
    
    var body: some View {
        ZStack {
            if let image = coverImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .ignoresSafeArea(.container, edges: .top)
            } else {
                Color.secondary.opacity(0.6).frame(width: UIScreen.main.bounds.width)
                    .aspectRatio(1, contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea(.container, edges: .top)
            }
            
            VStack(alignment: .leading) {
                Spacer()
                
                VStack(alignment: .leading) {
                    TextField("Recipe Name", text: $recipeName, axis: .vertical)
                        .font(.custom("Poppins-Medium", size: 24))
                        .foregroundColor(.white.opacity(0.8))
                        .lineLimit(2)
                    
                    Button {
                        showingPhotoPicker = true
                    } label: {
                        HStack {
                            Image(systemName: "photo")
                                .foregroundColor(.white)
                            
                            Text("Change photo")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-Regular", size: 14))
                        }
                    }
                }
                .padding()
            }
        }
        .listRowInsets(EdgeInsets())
        .sheet(isPresented: $showingPhotoPicker) {
            PhotoPicker(image: $coverImage)
        }
    }
}

struct RecipeFormHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFormHeaderView(recipeName: .constant("Pizza"), coverImage: .constant(nil))
    }
}
