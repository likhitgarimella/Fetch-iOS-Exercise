//
//  MealDetailView.swift
//  Fetch
//
//  Created by Likhit Garimella on 5/25/24.
//

import SwiftUI

struct MealDetailView: View {
    let mealID: String
    @ObservedObject var viewModel: MealViewModel    // view model

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let errorMessage = viewModel.errorMessage {  // error
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }
                else if viewModel.isLoading {   // loading
                    ProgressView("Loading...")
                        .padding()
                }
                else if let mealDetail = viewModel.selectedMealDetail { // display
                    // meal details:
                    AsyncImage(url: URL(string: mealDetail.strMealThumb)) { image in    // meal image
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(mealDetail.strMeal)    // meal title
                        .font(.title)
                        .padding()
                    
                    Text("Instructions")
                        .font(.headline)
                        .padding([.top, .leading, .trailing])
                    
                    Text(mealDetail.strInstructions)    // meal instructions
                        .padding([.leading, .trailing])
                    
                    Text("Ingredients")
                        .font(.headline)
                        .padding([.top, .leading, .trailing])
                    
                    ForEach(mealDetail.ingredients, id: \.name) { ingredient in // meal ingredients
                        Text("\(ingredient.name): \(ingredient.measure)")
                            .padding([.leading, .trailing])
                    }
                }
            }
        }
        .navigationTitle("Meal Details")    // title
        .onAppear {
            viewModel.fetchMealDetail(id: mealID)   // fetchMealDetail func
        }
    }
}
