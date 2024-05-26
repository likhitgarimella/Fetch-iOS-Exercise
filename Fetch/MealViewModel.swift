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
        guard let url = URL(string: mealListURL) else { // check if url is valid
            errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in    // create a data task with url
            if let data = data {
                do {
                    let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)  // decode the response data
                    DispatchQueue.main.async {
                        self.meals = mealResponse.meals.sorted { $0.strMeal < $1.strMeal }  // if successful, sort meals alphabetically
                        self.isLoading = false
                    }
                } catch {
                    DispatchQueue.main.async {  // error
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {  // error
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }.resume()
    }
    
    // fetches meal details by ID from the API
    func fetchMealDetail(id: String) {
        guard let url = URL(string: "\(mealDetailURL)\(id)") else { // check if url is valid
            errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in    // create a data task with url
            if let data = data {
                do {
                    let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)  // decode the response data
                    if let mealDetail = mealDetailResponse.meals.first {
                        DispatchQueue.main.async {  // if successful, set the selectedMealDetail property
                            self.selectedMealDetail = mealDetail
                            self.isLoading = false
                        }
                    }
                } catch {
                    DispatchQueue.main.async {  // error
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {  // error
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }.resume()
    }
}
