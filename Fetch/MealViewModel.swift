//
//  MealViewModel.swift
//  Fetch
//
//  Created by Likhit Garimella on 5/24/24.
//

import Foundation

class MealViewModel: ObservableObject {
    @Published var meals: [MealModel] = []
    @Published var selectedMealDetail: MealDetail?

    private let mealListURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    private let mealDetailURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="

    func fetchMeals() {
        guard let url = URL(string: mealListURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                // error
                // do try catch
                if let mealResponse = try? JSONDecoder().decode(MealResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.meals = mealResponse.meals.sorted { $0.strMeal < $1.strMeal }
                    }
                }
            }
        }.resume()
    }

    func fetchMealDetail(id: String) {
        guard let url = URL(string: "\(mealDetailURL)\(id)") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                // JSONDecoder
                // model for meal detail
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let mealDetail = MealDetail.from(json: json) {
                    DispatchQueue.main.async {
                        self.selectedMealDetail = mealDetail
                    }
                }
            }
        }.resume()
    }
}
