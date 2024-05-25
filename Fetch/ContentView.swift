//
//  ContentView.swift
//  Fetch
//
//  Created by Likhit Garimella on 5/24/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MealViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(mealID: meal.idMeal, viewModel: viewModel)) {
                    Text(meal.strMeal)
//                    Text(meal.strMealThumb)
//                    Text(meal.idMeal)
                }
            }
            .navigationTitle("Desserts")
            .onAppear {
                viewModel.fetchMeals()
            }
        }
    }
}

struct MealDetailView: View {
    let mealID: String
    @ObservedObject var viewModel: MealViewModel

    var body: some View {
        VStack(alignment: .leading) {
            if let mealDetail = viewModel.selectedMealDetail {
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
            } else {
                ProgressView("Loading...")
                    .onAppear {
                        viewModel.fetchMealDetail(id: mealID)
                    }
            }
        }
        .navigationTitle("Meal Details")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
