//
//  GroceryApp.swift
//  Grocery
//
//  Created by Mitch Brown on 2024-08-27.
//

import SwiftUI
import SwiftData

@main
struct GroceryApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: [groceryItem.self, groceryListItem.self, Store.self])
    }
}
