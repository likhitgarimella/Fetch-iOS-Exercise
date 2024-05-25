//
//  MealViewModel.swift
//  Fetch
//
//  Created by Likhit Garimella on 5/24/24.
//

import Foundation
import Combine

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []   // array of Meal objects
    @Published var selectedMealDetail: MealDetail?  // optional
    @Published var isLoading = false
    @Published var errorMessage: String?    // optional
    
    private var cancellables = Set<AnyCancellable>()
    
    // api end points
    private let mealListURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    private let mealDetailURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    // fetches the list of meals from the API
    func fetchMeals() {
        // check if url is valid
        guard let url = URL(string: mealListURL) else {
            errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        
        // create a data task with url
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    // decode the response data
                    let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
                    DispatchQueue.main.async {
                        // if successful, sort meals alphabetically
                        self.meals = mealResponse.meals.sorted { $0.strMeal < $1.strMeal }
                        self.isLoading = false
                    }
                } catch {
                    // error
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                    }
                }
            } else if let error = error {
                // error
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }.resume()
    }
    
    // fetches meal details by ID from the API
    func fetchMealDetail(id: String) {
        // check if url is valid
        guard let url = URL(string: "\(mealDetailURL)\(id)") else {
            errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        
        // create a data task with url
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    // decode the response data
                    let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                    if let mealDetail = mealDetailResponse.meals.first {
                        // if successful, set the selectedMealDetail property
                        DispatchQueue.main.async {
                            self.selectedMealDetail = mealDetail
                            self.isLoading = false
                        }
                    }
                } catch {
                    // error
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                    }
                }
            } else if let error = error {
                // error
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }.resume()
    }
}
