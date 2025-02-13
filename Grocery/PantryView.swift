//
//  ContentView.swift
//  Grocery
//
//  Created by Mitch Brown on 2024-08-27.
//

import SwiftUI
import SwiftData

struct PantryView: View {
    
    @State private var path = NavigationPath()
    
    @State private var isPresenting: Bool = false
    
    @Environment(\.modelContext) private var context
    @Query var items: [groceryItem]
    @Query var groceryListItems: [groceryListItem]
    
    var body: some View {
            NavigationStack(path: $path) {
                List {
                    ForEach(items) { item in
                        
                        HStack {
                            Button {
                                path.append(item)
                            } label: {
                                HStack {
                                    Text(item.name)
                                        .tint(.primary)
                                    Spacer()
                                }
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            if (item.onlist == false) {
                                Button {
                                    item.onlist = true
                                    AddToList(item: item)
                                } label: {
                                    Image(systemName: "plus.circle")
                                        .imageScale(.large)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                .tint(.blue)
                            }
                            if (item.onlist == true) {
                                Button {
                                    item.onlist = false
                                    DeleteGroceryListItem(item)
                                } label: {
                                    Image(systemName: "minus.circle")
                                        .imageScale(.large)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                .tint(.red)
                            }
                        }
                        .swipeActions (edge:.trailing) {
                            Button(role: .destructive) {
                                DeleteGroceryItem(item)
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
                .toolbar {
                    Button {
                        isPresenting = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .overlay {
                    if items.isEmpty {
                        ContentUnavailableView {
                            Label("No items in your pantry", systemImage: "carrot")
                        } description: {
                            Text("Try adding some items to your pantry")
                        } actions: {
                            Button {
                                isPresenting = true
                            } label: {
                                Text("Add Item")
                            }
                        }
                    }
                }
                .sheet(isPresented: $isPresenting) {
                    ItemAddView()
                }
                .navigationTitle("Pantry")
                .navigationDestination(for: groceryItem.self) { item in
                    ItemEditView(groceryItem: item)
                }
            }
    }
    
    func AddToList(item: groceryItem) {
        let newGroceryItem = groceryListItem(item: item)
        context.insert(newGroceryItem)
    }
    
    func DeleteGroceryItem(_ item: groceryItem) {
        context.delete(item)
    }
    
    func DeleteGroceryListItem(_ item: groceryItem) {
        let results = groceryListItems.filter {$0.groceryItem == item}
        if !results.isEmpty {
            context.delete(results.first!)
        }
    }
}

#Preview {
    PantryView()
}
