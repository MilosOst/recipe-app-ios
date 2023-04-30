//
//  RecipeFormViewModel.swift
//  recipe-app
//
//  Created by Milos on 2023-04-29.
//

import Foundation
import UIKit

@MainActor
class RecipeFormViewModel: ObservableObject {
    @Published var recipe = RecipeSubmission()
    @Published var coverImage: UIImage? = nil
    @Published var uploadingImage = false
    
    private var uploadingRecipe = false
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    var submissionDisabled: Bool {
        uploadingImage || !recipe.isValid || uploadingRecipe
    }
    
    func addIngredient() {
        recipe.ingredients.append(.init())
    }
    
    func addStep() {
        recipe.steps.append(.init(content: ""))
    }
    
    func resetRecipe() {
        coverImage = nil
        recipe.reset()
    }
    
    func toggleCategory(_ category: RecipeCategory) {
        if recipe.categories.contains(category) {
            recipe.categories.remove(category)
        } else {
            recipe.categories.insert(category)
        }
    }
    
    func uploadImage() async {
        guard let coverImage = coverImage else {
            return
        }
            
        uploadingImage = true
        do {
            let imageName = try await APIService.shared.uploadRecipeImage(image: coverImage)
            recipe.coverPhoto = imageName
        } catch {
            print(error)
        }
        
        uploadingImage = false
    }
    
    func uploadRecipe() async {
        guard !submissionDisabled else { return }
        
        uploadingRecipe = true
        showingAlert = false
        alertMessage = ""
        do {
            try await APIService.shared.uploadRecipe(recipe: recipe)
            alertMessage = "Your recipe has been posted."
            resetRecipe()
        } catch APIError.badRequest(let errors) {
            alertMessage = errors.first?.message ?? "Sorry, there was an issue uploading your recipe."
        } catch APIError.httpStatusCodeFailed(let err) {
            alertMessage = err.message
        } catch {
            print(error)
            alertMessage = "Sorry, there was an issue uploading your recipe."
        }
        
        showingAlert = true
        uploadingRecipe = false
    }
}
