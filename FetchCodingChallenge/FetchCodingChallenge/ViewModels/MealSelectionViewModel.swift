//
//  MealSelectionViewModel.swift
//  FetchCodingChallenge
//
//  Created by Justin Rudolph on 7/30/24.
//

import Foundation

// The ViewModel is responsible for handling the logic of fetching meal details from the API

class MealSelectionViewModel: ObservableObject {
    @Published var mealDetails: MealDetails?
    
    init(mealID: String) {
        Task {
            await fetchMealDetails(mealID: mealID)
        }
    }
    
    // Asynchronous function to fetch meal details based on the meal ID
    func fetchMealDetails(mealID: String) async {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"
        
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let mealDetailsResponse = try JSONDecoder().decode(MealDetailsResponse.self, from: data)
            DispatchQueue.main.async { [weak self] in
                self?.mealDetails = mealDetailsResponse.meals.first
            }
        } catch {
            print("Error fetching meal details: \(error)")
        }
    }
}
