//
//  MealSelectionView.swift
//  FetchCodingChallenge
//
//  Created by Justin Rudolph on 7/30/24.
//

import SwiftUI

// View for displaying meal details
struct MealSelectionView: View {
    @StateObject private var viewModel: MealSelectionViewModel
    let mealID: String
    
    init(mealID: String) {
        self.mealID = mealID
        _viewModel = StateObject(wrappedValue: MealSelectionViewModel(mealID: mealID))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                // Check if meal details are available
                if let mealDetails = viewModel.mealDetails {
                    // Display meal name
                    Text(mealDetails.strMeal)
                        .font(.largeTitle)
                        .padding(.bottom, 5)
                        .multilineTextAlignment(.center)
                    
                    // Display meal category
                    Text(mealDetails.strCategory)
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    // Display meal area (origin)
                    Text(mealDetails.strArea)
                        .font(.subheadline)
                        .padding(.bottom, 10)
                    
                    // Display meal image if URL is valid
                    if let url = URL(string: mealDetails.strMealThumb) {
                        AsyncImage(url: url) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 200)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 2)
                                    )
                                // Indicates an error loading theimage
                            } else if phase.error != nil {
                                Color.red
                                    .frame(width: 200, height: 200)
                            } else {
                                // Loading indicator
                                ProgressView()
                                    .frame(width: 200, height: 200)
                            }
                        }
                        .padding(.bottom, 10)
                    }
                    
                    // Display meal instructions
                    Text(mealDetails.strInstructions)
                        .padding(.horizontal)
                    
                    Divider()
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    
                    // `ForEach` iterates over an array of tuples where each tuple contains an index and a tuple of (ingredient, measurement)
                    // `mealDetails.ingredients.indices` provides a range of indices for the ingredients array
                    // `zip(mealDetails.ingredients.indices, zip(mealDetails.ingredients, mealDetails.measurements))` zips these indices with the zipped ingredients and measurements arrays
                    // `id: \.0` uses the index from the first element of the outer tuple as the unique identifier
                    
                    ForEach(Array(zip(mealDetails.ingredients.indices, zip(mealDetails.ingredients, mealDetails.measurements))), id: \.0) { index, element in
                        
                        // `element` is a tuple containing the index and another tuple (ingredient, measurement)
                        // Destructure `element` to extract `ingredient` and `measurement`
                        let (ingredient, measurement) = element
                        HStack {
                            Text(ingredient)
                            Spacer()
                            Text(measurement)
                        }
                        .padding(.horizontal)
                    }
                } else {
                    // Loading indicator while fetching meal details
                    ProgressView()
                }
            }
            .padding(.horizontal)
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Gradient(colors: [.teal, .cyan, .green]).opacity(0.6))
    }
}

#Preview {
    MealSelectionView(mealID: "53049")
}
