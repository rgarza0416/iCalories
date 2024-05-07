//
//  AddFoodView.swift
//  iCalories
//
//  Created by Ricardo Garza on 4/4/24.
//

import SwiftUI

struct AddFoodView: View {
    @Environment (\.managedObjectContext) var managedObjectContext
    @Environment (\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form {
            Section {
                TextField("Food Name", text: $name)
                
                VStack {
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 10)
                }
                .padding()
            
                HStack{
                    Spacer()
                    Button("Submit") {
                        DataController().addFood(name: name, calories: calories, context: managedObjectContext)
                        dismiss()
                            
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    AddFoodView()
}
