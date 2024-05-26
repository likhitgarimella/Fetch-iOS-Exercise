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
                }
                else if viewModel.isLoading {   // loading
                    ProgressView("Loading...")
                        .padding()
                }
                else {  // display
                    List(viewModel.meals) { meal in // tableview/list
                        NavigationLink(destination: MealDetailView(mealID: meal.idMeal, viewModel: viewModel)) {    // navigate to meal details
                            HStack {
                                AsyncImage(url: URL(string: meal.strMealThumb)) { image in  // Display meal image
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                } placeholder: {
                                    ProgressView()
                                }
                                Text(meal.strMeal)  // Display meal name
                            }
                        }
                    }
                }
            }
            .navigationTitle("Desserts")    // title
            .onAppear {
                viewModel.fetchMeals()  // fetchMeals func
            }
        }
    }
}
