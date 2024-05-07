//
//  ContentView.swift
//  iCalories
//
//  Created by Ricardo Garza on 4/4/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment (\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<FoodEntity>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("\(Int(totalCaloriesToday())) Kcal (Today)")
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                List {
                    ForEach(food) { food in
                        NavigationLink(destination: EditFoodView(food: food)) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(food.name!)
                                    .bold()
                                
                                Text("\(Int(food.calories))") + Text(" calories").foregroundStyle(.red)
                            }
                            Spacer()
                            
                            Text(calcTimeSince(date: food.date!))
                                .foregroundStyle(.gray)
                                .italic()
                        }
                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
            }
            .navigationTitle("iCalories")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddView.toggle()
                    }, label: {
                        Label("Add Food", systemImage: "plus.circle")
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView, content: {
                AddFoodView()
            })
        }
        .navigationViewStyle(.stack)
    }
    
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map { food[$0] }.forEach(managedObjectContext.delete)
            
            DataController().save(context: managedObjectContext)
            }
        }
    
    
    private func totalCaloriesToday() -> Double {
        var caloriesToday: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!) {
                caloriesToday += item.calories
            }
        }
        
        return caloriesToday
    }
}

#Preview {
    ContentView()
}
