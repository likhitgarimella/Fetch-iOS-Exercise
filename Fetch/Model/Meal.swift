//
//  Meal.swift
//  Fetch
//
//  Created by Likhit Garimella on 5/25/24.
//

import Foundation

struct Meal: Identifiable, Codable {
    let idMeal: String  // meal id
    let strMeal: String // meal name
    
    let strMealThumb: String    // meal image
    
    var id: String { idMeal }   // identifier from idMeal
}

struct MealResponse: Codable {
    let meals: [Meal]   // array of Meal objects
}
