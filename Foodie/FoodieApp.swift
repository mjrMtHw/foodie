//
//  FoodieApp.swift
//  Foodie
//
//  Created by Matthew Riley on 2/27/23.
//

import SwiftUI

@main
struct FoodieApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
