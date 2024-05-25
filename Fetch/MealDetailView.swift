//
//  MealDetailView.swift
//  Fetch
//
//  Created by Likhit Garimella on 5/25/24.
//

import SwiftUI

struct MealDetailView: View {
    let mealID: String
    @ObservedObject var viewModel: MealViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if let mealDetail = viewModel.selectedMealDetail {
                    Text(mealDetail.strMeal)
                        .font(.title)
                        .padding()

                    Text("Instructions")
                        .font(.headline)
                        .padding([.top, .leading, .trailing])

                    Text(mealDetail.strInstructions)
                        .padding([.leading, .trailing])

                    Text("Ingredients")
                        .font(.headline)
                        .padding([.top, .leading, .trailing])

                    ForEach(mealDetail.ingredients, id: \.name) { ingredient in
                        Text("\(ingredient.name): \(ingredient.measure)")
                            .padding([.leading, .trailing])
                    }
                }
            }
        }
        .navigationTitle("Meal Details")
        .onAppear {
            viewModel.fetchMealDetail(id: mealID)
        }
    }
}
