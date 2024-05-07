//
//  iCaloriesApp.swift
//  iCalories
//
//  Created by Ricardo Garza on 4/4/24.
//

import SwiftUI

@main
struct iCaloriesApp: App {
    @StateObject private var dataController = DataController()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
