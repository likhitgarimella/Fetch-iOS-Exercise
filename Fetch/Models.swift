//
//  Models.swift
//  Fetch
//
//  Created by Likhit Garimella on 5/25/24.
//

import Foundation

struct Meal: Identifiable, Codable {
    let idMeal: String
    let strMeal: String
    
    var id: String { idMeal }
}

struct MealResponse: Codable {
    let meals: [Meal]
}

struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}

struct MealDetail: Codable {
    let strMeal: String
    let strInstructions: String
    let ingredients: [Ingredient]
    
    struct Ingredient: Codable {
        let name: String
        let measure: String
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        
        var ingredients: [Ingredient] = []
        for i in 1...20 {
            if let nameKey = CodingKeys(stringValue: "strIngredient\(i)"),
               let measureKey = CodingKeys(stringValue: "strMeasure\(i)"),
               let name = try? container.decode(String.self, forKey: nameKey),
               !name.isEmpty,
               let measure = try? container.decode(String.self, forKey: measureKey),
               !measure.isEmpty {
                ingredients.append(Ingredient(name: name, measure: measure))
            }
        }
        self.ingredients = ingredients
    }
    
    enum CodingKeys: String, CodingKey {
        case strMeal
        case strInstructions
    }
}
