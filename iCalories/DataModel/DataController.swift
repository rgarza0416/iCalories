//
//  DataController.swift
//  iCalories
//
//  Created by Ricardo Garza on 4/4/24.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FoodModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    //This is to save data
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data Saved!")
        } catch {
            print("We could not save the data...")
        }
    }
    
    func addFood(name: String, calories: Double, context: NSManagedObjectContext) {
        let food = FoodEntity(context: context)
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.calories = calories
        
        save(context: context)
    }
    
    func editFood(food: FoodEntity, name: String, calories: Double, context: NSManagedObjectContext) {
        food.date = Date()
        food.name = name
        food.calories = calories
        
        save(context: context)
    }
}
