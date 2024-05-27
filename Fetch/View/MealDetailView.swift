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
                    
                    if let url = URL(string: mealDetail.strMealThumb ?? "") {   // url of image
                        CachedAsyncImage(url: url)  // meal image from url
                            .frame(maxWidth: .infinity)
                            .aspectRatio(contentMode: .fit)
                            .padding([.top, .bottom])
                    }
                    // #1
                    Group {
                        Text(mealDetail.strMeal ?? "")  // meal name
                            .font(.title)
                        
                        if let strDrinkAlternate = mealDetail.strDrinkAlternate {   // check for null
                            Text("Drink: \(strDrinkAlternate)")
                        }
                        
                        if let strCategory = mealDetail.strCategory {   // check for null
                            Text("Category: \(strCategory)")
                        }
                        
                        if let strArea = mealDetail.strArea {   // check for null
                            Text("Area: \(strArea)")
                        }
                        
                        Text("Instructions:")
                            .font(.headline)
                        
                        Text(mealDetail.strInstructions ?? "")  // meal instructions
                            .multilineTextAlignment(.leading)
                        
                        if let strTags = mealDetail.strTags {   // check for null
                            Text("Tags: \(strTags)")
                        }
                        
                        Text("Ingredients:")
                            .font(.headline)
                        
                    }
                    .padding(.top, 4)
                    .padding(.bottom, 4)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    // #2
                    Group {
                        ForEach(mealDetail.ingredients, id: \.name) { ingredient in // meal ingredients
                            Text("\(ingredient.name): \(ingredient.measure)")
                        }
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    // #3
                    Group {
                        if let strYoutube = mealDetail.strYoutube { // check for null
                            if let url = URL(string: strYoutube) {
                                Link("Watch on YouTube", destination: url)
                            } else {
                                Text("YouTube: \(strYoutube)")
                            }
                        }
                        
                        if let strSource = mealDetail.strSource {   // check for null
                            if let url = URL(string: strSource) {
                                Link("Blog Source", destination: url)
                            } else {
                                Text("Source: \(strSource)")
                            }
                        }
                        
                        if let strImageSource = mealDetail.strImageSource { // check for null
                            Text("Image Source: \(strImageSource)")
                        }
                        
                        if let strCreativeCommonsConfirmed = mealDetail.strCreativeCommonsConfirmed {   // check for null
                            Text("Creative Commons: \(strCreativeCommonsConfirmed)")
                        }
                        
                        if let dateModified = mealDetail.dateModified { // check for null
                            Text("Date Modified: \(dateModified)")
                        }
                    }
                    .padding(.top, 4)
                    .padding(.bottom, 4)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    
                }
            }
        }
        .navigationTitle("Meal Details")    // nav bar title
        .onAppear {
            viewModel.fetchMealDetail(id: mealID)   // fetchMealDetail func
        }
    }
}
