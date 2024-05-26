//
//  MealViewModel.swift
//  Fetch
//
//  Created by Likhit Garimella on 5/24/24.
//

import Foundation
import Combine

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var selectedMealDetail: MealDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    private let mealListURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    private let mealDetailURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    func fetchMeals() {
        guard let url = URL(string: mealListURL) else {
            errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.meals = mealResponse.meals.sorted { $0.strMeal < $1.strMeal }
                        self.isLoading = false
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }.resume()
    }
    
    func fetchMealDetail(id: String) {
        guard let url = URL(string: "\(mealDetailURL)\(id)") else {
            errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                    if let mealDetail = mealDetailResponse.meals.first {
                        DispatchQueue.main.async {
                            self.selectedMealDetail = mealDetail
                            self.isLoading = false
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }.resume()
    }
}
