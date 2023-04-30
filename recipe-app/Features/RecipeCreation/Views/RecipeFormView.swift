//
//  RecipeFormView.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import SwiftUI

struct RecipeFormView: View {
    @StateObject private var vm = RecipeFormViewModel()
    
    private let numFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.zeroSymbol = ""
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            List {
                RecipeFormHeaderView(recipeName: $vm.recipe.name, coverImage: $vm.coverImage)
                    .onChange(of: vm.coverImage) { newImage in
                        Task { @MainActor in
                            await vm.uploadImage()
                        }
                    }
                
                descriptionArea
                
                categoriesArea
                
                durationArea
                
                ingredientsHeader
                
                ForEach($vm.recipe.ingredients) { $ingredient in
                    RecipeFormIngredientView(ingredient: $ingredient)
                }
                .onDelete { indexSet in
                    vm.recipe.ingredients.remove(atOffsets: indexSet)
                }
                
                stepsHeader
                
                ForEach($vm.recipe.steps) { $step in
                    TextField("Explain this step.", text: $step.content, axis: .vertical)
                        .lineLimit(12)
                        .font(.custom("Poppins-Light", size: 14))
                }
                .onDelete { indexSet in
                    vm.recipe.steps.remove(atOffsets: indexSet)
                }
                
            }
            .listStyle(.plain)
            .navigationTitle("Create Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(.container, edges: .top)
            .toolbar {
                toolbar()
            }
            .alert(vm.alertMessage, isPresented: $vm.showingAlert) { }
        }
    }
    
    private var descriptionArea: some View {
        VStack(alignment: .leading) {
            Text("Description")
                .font(.custom("Poppins-Medium", size: 16))
                .shadow(color: .secondary, radius: 1)
            
            TextField("Describe your recipe briefly (optional)", text: $vm.recipe.description, axis: .vertical)
                .lineLimit(10)
                .font(.custom("Poppins-Light", size: 14))
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
    
    private var durationArea: some View {
        VStack(alignment: .leading) {
            Text("Cooking Time (In minutes)")
                .font(.custom("Poppins-Medium", size: 16))
                .shadow(color: .secondary, radius: 1)
            
            TextField("How long does it take to make this recipe?", value: $vm.recipe.minutesToMake, formatter: numFormatter)
                .keyboardType(.numberPad)
                .font(.custom("Poppin-Regular", size: 16))
        }
    }
    
    private var ingredientsHeader: some View {
        HStack {
            Text("Ingredients")
                .font(.custom("Poppins-Medium", size: 16))
                .shadow(color: .secondary, radius: 1)
            
            Spacer()
            
            Button {
                vm.addIngredient()
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .accessibilityAddTraits([.isButton])
                    .accessibilityLabel("Add Ingredient")
                    .padding(6)
                    .background(.blue)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
        }
    }
    
    private var stepsHeader: some View {
        HStack {
            Text("Steps")
                .font(.custom("Poppins-Medium", size: 16))
                .shadow(color: .secondary, radius: 1)
            
            Spacer()
            
            Button {
                vm.addStep()
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .accessibilityAddTraits([.isButton])
                    .accessibilityLabel("Add Ingredient")
                    .padding(6)
                    .background(.blue)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
        }
    }
    
    @ToolbarContentBuilder
    private func toolbar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(role: .destructive) {
                vm.resetRecipe()
            } label: {
                Image(systemName: "trash")
            }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Submit") {
                Task { @MainActor in
                    await vm.uploadRecipe()
                }
            }
            .font(.custom("Poppins-Regular", size: 16).bold())
            .foregroundColor(.blue)
            .disabled(vm.submissionDisabled)
        }
    }
    
    private var categoriesArea: some View {
        Section("Categories") {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(RecipeCategory.allCases) { category in
                        Text(String(describing: category).capitalized)
                            .font(.custom("Poppins-Medium", size: 12))
                            .padding(8)
                            .foregroundColor(Color(uiColor: .systemBackground))
                            .background(vm.recipe.categories.contains(category) ? .green : .primary)
                            .clipShape(Capsule())
                            .onTapGesture {
                                vm.toggleCategory(category)
                            }
                
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
}

struct RecipeFormView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecipeFormView()
                .preferredColorScheme(.light)
            
            RecipeFormView()
                .preferredColorScheme(.dark)
        }
    }
}
