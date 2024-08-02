//
//  MealsListViewModel.swift
//  FetchCodingChallenge
//
//  Created by Justin Rudolph on 7/30/24.
//

import Foundation

// The ViewModel is responsible for handling the logic of fetching a list of meals from the API

class MealsListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    
    init() {
        Task {
            await fetchMeals()
        }
    }
    
    // Function to fetch meals asynchronously from the API
    func fetchMeals() async {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(MealResponse.self, from: data)
            let sortedMeals = response.meals.sorted(by: { $0.strMeal < $1.strMeal })  // Sort meals alphabetically
            DispatchQueue.main.async { [weak self] in
                self?.meals = sortedMeals
            }
        } catch {
            print("Error fetching meals: \(error.localizedDescription)")
        }
    }
}
