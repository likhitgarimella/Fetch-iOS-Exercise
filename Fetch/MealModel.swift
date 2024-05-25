//
//  Meal.swift
//  Fetch
//
//  Created by Likhit Garimella on 5/24/24.
//

import Foundation

struct MealModel: Identifiable, Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    var id: String { idMeal }
}

struct MealResponse: Codable {
    let meals: [MealModel]
}

struct MealDetail: Codable {
    let strMeal: String
    let strInstructions: String
    let ingredients: [Ingredient]
    
    struct Ingredient: Codable {
        let name: String
        let measure: String
    }
    
    static func from(json: [String: Any]) -> MealDetail? {
        guard let strMeal = json["strMeal"] as? String,
              let strInstructions = json["strInstructions"] as? String else {
            return nil
        }
        
        var ingredients: [Ingredient] = []
        for i in 1...20 {
            if let name = json["strIngredient\(i)"] as? String, !name.isEmpty,
               let measure = json["strMeasure\(i)"] as? String, !measure.isEmpty {
                ingredients.append(Ingredient(name: name, measure: measure))
            }
        }
        
        return MealDetail(strMeal: strMeal, strInstructions: strInstructions, ingredients: ingredients)
    }
}
