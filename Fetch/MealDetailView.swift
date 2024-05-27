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
                } else if viewModel.isLoading { // loading
                    ProgressView("Loading...")
                        .padding()
                } else if let mealDetail = viewModel.selectedMealDetail {   // display
                    if let url = URL(string: mealDetail.strMealThumb ?? "") {
                        CachedAsyncImage(url: url)  // meal image
                            .frame(maxWidth: .infinity)
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    }
                    
                    Group {
                        Text(mealDetail.strMeal ?? "")  // meal name
                            .font(.title)
                            .padding([.top, .leading, .trailing])
                        
                        if let strDrinkAlternate = mealDetail.strDrinkAlternate {
                            Text("Drink: \(strDrinkAlternate)")
                                .padding([.leading, .trailing])
                        }
                        
                        if let strCategory = mealDetail.strCategory {
                            Text("Category: \(strCategory)")
                                .padding([.leading, .trailing])
                        }
                        
                        if let strArea = mealDetail.strArea {
                            Text("Area: \(strArea)")
                                .padding([.leading, .trailing])
                        }
                        
                        Text("Instructions")
                            .font(.headline)
                            .padding([.top, .leading, .trailing])
                        
                        Text(mealDetail.strInstructions ?? "")  // meal instructions
                            .padding([.leading, .trailing])
                        
                        if let strTags = mealDetail.strTags {
                            Text("Tags: \(strTags)")
                                .padding([.leading, .trailing])
                        }
                        
                        if let strYoutube = mealDetail.strYoutube {
                            if let url = URL(string: strYoutube) {
                                Link("Watch on YouTube", destination: url)
                                    .padding([.leading, .trailing])
                            } else {
                                Text("YouTube: \(strYoutube)")
                                    .padding([.leading, .trailing])
                            }
                        }
                        
                        if let strSource = mealDetail.strSource {
                            if let url = URL(string: strSource) {
                                Link("Source", destination: url)
                                    .padding([.leading, .trailing])
                            } else {
                                Text("Source: \(strSource)")
                                    .padding([.leading, .trailing])
                            }
                        }
                    }
                    
                    Text("Ingredients")
                        .font(.headline)
                        .padding([.top, .leading, .trailing])
                    
                    ForEach(mealDetail.ingredients, id: \.name) { ingredient in // meal ingredients
                        Text("\(ingredient.name): \(ingredient.measure)")
                            .padding([.leading, .trailing])
                    }
                    
                    if let strImageSource = mealDetail.strImageSource {
                        Text("Image Source: \(strImageSource)")
                            .padding([.leading, .trailing])
                    }
                    
                    if let strCreativeCommonsConfirmed = mealDetail.strCreativeCommonsConfirmed {
                        Text("Creative Commons: \(strCreativeCommonsConfirmed)")
                            .padding([.leading, .trailing])
                    }
                    
                    if let dateModified = mealDetail.dateModified {
                        Text("Date Modified: \(dateModified)")
                            .padding([.leading, .trailing])
                    }
                    
                }
            }
        }
        .navigationTitle("Meal Details")    // nav bar title
        .onAppear {
            viewModel.fetchMealDetail(id: mealID)   // fetchMealDetail func
        }
    }
}
