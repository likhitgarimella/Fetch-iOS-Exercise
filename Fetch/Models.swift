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

//struct MealDetail: Codable {
//    let strMeal: String
//    let strInstructions: String
//    let strMealThumb: String
//    let ingredients: [Ingredient]   // array of Ingredient structs...
//    
//    struct Ingredient: Codable {    // inside Ingredient...
//        let name: String
//        let measure: String
//    }
//    
//    init(from decoder: Decoder) throws {    // decode json
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        strMeal = try container.decode(String.self, forKey: .strMeal)
//        strInstructions = try container.decode(String.self, forKey: .strInstructions)
//        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
//        
//        // looping over possible ingredient and measure pairs up to 20 and creating Ingredient objects
//        var ingredients: [Ingredient] = []
//        for i in 1...20 {
//            let nameKey = CodingKeys(stringValue: "strIngredient\(i)")
//            let measureKey = CodingKeys(stringValue: "strMeasure\(i)")
//            
//            if let nameKey = nameKey, let measureKey = measureKey,
//               let name = try? container.decodeIfPresent(String.self, forKey: nameKey),
//                !name.isEmpty,
//                    let measure = try? container.decodeIfPresent(String.self, forKey: measureKey),
//                        !measure.isEmpty {
//                ingredients.append(Ingredient(name: name, measure: measure))
//            }
//        }
//        self.ingredients = ingredients
//    }
//    
//    enum CodingKeys: String, CodingKey {
//        case strMeal
//        case strInstructions
//        case strMealThumb
//    }
//}

struct MealDetail: Codable {
    let idMeal: String?
    let strMeal: String?
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    struct Ingredient: Codable {
        let name: String
        let measure: String
    }

    var ingredients: [Ingredient] {
        var ingredients: [Ingredient] = []
        for i in 1...20 {
            if let nameKey = self.value(forKey: "strIngredient\(i)") as? String,
               let measureKey = self.value(forKey: "strMeasure\(i)") as? String,
               !nameKey.isEmpty, !measureKey.isEmpty {
                ingredients.append(Ingredient(name: nameKey, measure: measureKey))
            }
        }
        return ingredients
    }
}

extension MealDetail {
    func value(forKey key: String) -> Any? {
        return Mirror(reflecting: self).children.first { $0.label == key }?.value
    }
}
