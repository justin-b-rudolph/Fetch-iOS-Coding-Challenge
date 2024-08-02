//
//  MealsListView.swift
//  FetchCodingChallenge
//
//  Created by Justin Rudolph on 7/30/24.
//

import SwiftUI

// View for displaying the list of all meal items
struct MealsListView: View {
    @StateObject private var viewModel = MealsListViewModel()
    
    var body: some View {
        // Navigation stack to manage navigation within the view
        NavigationStack {
            // List to display the meals, using the meals array from the viewModel
            List(viewModel.meals) { meal in
                // For each meal, create a MealsListItemView to display it
                MealsListItemView(meal: meal)
            }
            .navigationTitle("Dessert Meals")
            .background(Gradient(colors: [.teal, .cyan, .green]).opacity(0.6))
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    MealsListView()
}
