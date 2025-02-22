//
//  EditFoodView.swift
//  iCalories
//
//  Created by Ricardo Garza on 4/5/24.
//

import SwiftUI

struct EditFoodView: View {
    
    @Environment (\.managedObjectContext) var managedObjectContext
    @Environment (\.dismiss) var dismiss

    var food: FetchedResults<FoodEntity>.Element
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form {
            Section {
                TextField("\(food.name!)", text: $name)
                    .onAppear {
                        name = food.name!
                        calories = food.calories
                    }
                VStack {
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 10)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().editFood(food: food, name: name, calories: calories, context: managedObjectContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}


