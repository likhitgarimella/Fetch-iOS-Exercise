//
//  ContentView.swift
//  Fetch
//
//  Created by Likhit Garimella on 5/24/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MealViewModel()    // view model
    
    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = viewModel.errorMessage {  // error
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.isLoading { // loading
                    ProgressView("Loading...")
                        .padding()
                } else {    // display
                    List(viewModel.meals) { meal in // tableview/list
                        NavigationLink(destination: MealDetailView(mealID: meal.idMeal, viewModel: viewModel)) {    // navigate to meal details
                            HStack {
                                if let url = URL(string: meal.strMealThumb) {
                                    CachedAsyncImage(url: url)  // meal image
                                        .frame(width: 50, height: 50)
                                }
                                Text(meal.strMeal)  // meal name
                            }
                        }
                    }
                }
            }
            .navigationTitle("Desserts")    // nav bar title
            .onAppear {
                viewModel.fetchMeals()  // fetchMeals func
            }
        }
    }
}
