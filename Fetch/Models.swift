//
//  Models.swift
//  Fetch
//
//  Created by Likhit Garimella on 5/25/24.
//

import Foundation

struct Meal: Identifiable, Codable {
    let idMeal: String  // meal id
    let strMeal: String // meal name
    
    let strMealThumb: String
    
    var id: String { idMeal }   // identifier from idMeal
}

struct MealResponse: Codable {
    let meals: [Meal]   // array of Meal objects
}

struct MealDetailResponse: Codable {
    let meals: [MealDetail] // array of MealDetail objects
}

struct MealDetail: Codable {
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String
    let ingredients: [Ingredient]   // array of Ingredient structs...
    
    struct Ingredient: Codable {    // inside Ingredient...
        let name: String
        let measure: String
    }
    
    init(from decoder: Decoder) throws {    // decode json
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        
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
        case strMealThumb
    }
}
