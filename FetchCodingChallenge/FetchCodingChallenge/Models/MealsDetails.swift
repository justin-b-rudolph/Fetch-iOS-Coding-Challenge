//
//  MealsDetails.swift
//  FetchCodingChallenge
//
//  Created by Justin Rudolph on 8/1/24.
//

import Foundation

struct MealDetailsResponse: Codable {
    let meals: [MealDetails]
}

struct MealDetails: Codable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let ingredients: [String]
    let measurements: [String]
    
    // Coding keys to map JSON keys to struct properties
    enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strCategory
        case strArea
        case strInstructions
        case strMealThumb
    }
    
    // Additional coding keys for dynamic keys
    enum AdditionalKeys: String, CodingKey {
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    // Initializer to decode JSON data into MealDetails
    init(from decoder: Decoder) throws {
        // Decode the basic details using CodingKeys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strCategory = try container.decode(String.self, forKey: .strCategory)
        strArea = try container.decode(String.self, forKey: .strArea)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        
        // Decode the additional dynamic keys for ingredients and measurements
        let additionalContainer = try decoder.container(keyedBy: AdditionalKeys.self)
        ingredients = (1...20)
            .compactMap { try? additionalContainer.decode(String.self, forKey: AdditionalKeys(stringValue: "strIngredient\($0)")!) }
            .filter { !$0.isEmpty }  // Filter out any empty ingredient strings
        measurements = (1...20)
            .compactMap { try? additionalContainer.decode(String.self, forKey: AdditionalKeys(stringValue: "strMeasure\($0)")!) }
            .filter { !$0.isEmpty }  // Filter out any empty measurement strings
    }
}
