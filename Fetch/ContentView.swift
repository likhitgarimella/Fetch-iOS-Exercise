//
//  ContentView.swift
//  Fetch
//
//  Created by Likhit Garimella on 5/24/24.
//

import SwiftUI

struct ContentView: View {
    // view model
    @StateObject private var viewModel = MealViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // error
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }
                // loading
                else if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                }
                // display
                else {
                    // tableview/list
                    List(viewModel.meals) { meal in
                        // navigate to meal details
                        NavigationLink(destination: MealDetailView(mealID: meal.idMeal, viewModel: viewModel)) {
                            Text(meal.strMeal)
                        }
                    }
                }
            }
            // title
            .navigationTitle("Desserts")
            .onAppear {
                // fetchMeals func
                viewModel.fetchMeals()
            }
        }
    }
}
