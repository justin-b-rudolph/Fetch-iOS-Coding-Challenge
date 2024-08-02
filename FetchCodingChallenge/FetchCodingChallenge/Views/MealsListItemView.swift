//
//  MealsListItemView.swift
//  FetchCodingChallenge
//
//  Created by Justin Rudolph on 7/30/24.
//

import SwiftUI

// View for displaying a specific meal item in the list
struct MealsListItemView: View {
    let meal: Meal
    @StateObject private var imageLoader: MealsListItemViewModel
    
    init(meal: Meal) {
        self.meal = meal
        // Initialize the ViewModel with the meal's image URL
        _imageLoader = StateObject(wrappedValue: MealsListItemViewModel(url: URL(string: meal.strMealThumb)))
    }
    
    var body: some View {
        // Navigation link to MealSelectionView, passing the meal ID
        NavigationLink(destination: MealSelectionView(mealID: meal.idMeal)){
            HStack {
                // Check if the image is loaded
                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipped()
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                } else {
                    // Display a progress view if the image is not loaded yet
                    ProgressView()
                        .frame(width: 50, height: 50)
                }
                
                Text(meal.strMeal)
                    .font(.headline)
            }
        }
    }
    
}

#Preview {
    MealsListItemView(meal: Meal(idMeal: "1", strMeal: "Sample Meal", strMealThumb: "https://www.themealdb.com/images/media/meals/llcbn01574260722.jpg"))
}
