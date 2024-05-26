//
//  Models.swift
//  Fetch
//
//  Created by Likhit Garimella on 5/25/24.
//

import Foundation

struct Meal: Identifiable, Codable {
    // meal id
    let idMeal: String
    // meal name
    let strMeal: String
    
    // identifier from idMeal
    var id: String { idMeal }
}

struct MealResponse: Codable {
    // array of Meal objects
    let meals: [Meal]
}

struct MealDetailResponse: Codable {
    // array of MealDetail objects
    let meals: [MealDetail]
}

struct MealDetail: Codable {
    let strMeal: String
    // addl params
    let strInstructions: String
    // array of Ingredient structs...
    let ingredients: [Ingredient]
    
    // inside Ingredient...
    struct Ingredient: Codable {
        let name: String
        let measure: String
    }
    
    // decode json
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        
        // looping over possible ingredient and measure pairs up to 20 and creating Ingredient objects
        var ingredients: [Ingredient] = []
        for i in 1...20 {
            let nameKey = CodingKeys(stringValue: "strIngredient\(i)")
            let measureKey = CodingKeys(stringValue: "strMeasure\(i)")
            
            if let nameKey = nameKey, let measureKey = measureKey,
               let name = try? container.decodeIfPresent(String.self, forKey: nameKey),
                !name.isEmpty,
                    let measure = try? container.decodeIfPresent(String.self, forKey: measureKey),
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
