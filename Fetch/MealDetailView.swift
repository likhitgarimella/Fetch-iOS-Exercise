//
//  MealDetailView.swift
//  Fetch
//
//  Created by Likhit Garimella on 5/25/24.
//

import SwiftUI

struct MealDetailView: View {
    let mealID: String
    // view model
    @ObservedObject var viewModel: MealViewModel

    var body: some View {
        // scroll view
        ScrollView {
            VStack(alignment: .leading) {
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
                else if let mealDetail = viewModel.selectedMealDetail {
                    // meal details:
                    // meal image
                    AsyncImage(url: URL(string: mealDetail.strMealThumb)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    // meal title
                    Text(mealDetail.strMeal)
                        .font(.title)
                        .padding()
                    
                    Text("Instructions")
                        .font(.headline)
                        .padding([.top, .leading, .trailing])
                    
                    // meal instructions
                    Text(mealDetail.strInstructions)
                        .padding([.leading, .trailing])
                    
                    Text("Ingredients")
                        .font(.headline)
                        .padding([.top, .leading, .trailing])
                    
                    // meal ingredients
                    ForEach(mealDetail.ingredients, id: \.name) { ingredient in
                        Text("\(ingredient.name): \(ingredient.measure)")
                            .padding([.leading, .trailing])
                    }
                }
            }
        }
        // title
        .navigationTitle("Meal Details")
        .onAppear {
            // fetchMealDetail func
            viewModel.fetchMealDetail(id: mealID)
        }
    }
}
