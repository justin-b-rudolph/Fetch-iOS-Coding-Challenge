//
//  Meal.swift
//  FetchCodingChallenge
//
//  Created by Justin Rudolph on 7/30/24.
//

import Foundation

struct MealResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String

    var id: String { idMeal }
}
