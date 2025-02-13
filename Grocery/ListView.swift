import SwiftUI
import SwiftData

struct ListView: View {
    @Environment(\.modelContext) private var context
    @Query var items: [groceryListItem]
    @Query var groceryItems: [groceryItem]
    
    @State private var path = NavigationPath()
    
    var body: some View {
            NavigationStack(path: $path) {
                List {
                    ForEach(items) { item in
                        var label = Image(systemName: "circle")
                        HStack {
                            Button {
                                path.append(item)
                            } label: {
                                HStack {
                                    Text(item.groceryItem.name)
                                        .tint(.primary)
                                    Spacer()
                                }
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            Button {
                                withAnimation (.easeOut){
                                    label = Image(systemName: "circle.checkmark")
                                    ChangeState(item)
                                }
                            } label: {
                                label
                                    .imageScale(.large)
                            }
                        }
                    }
                }
                .overlay {
                    if items.isEmpty {
                        ContentUnavailableView {
                            Label("Grocery list empty", systemImage: "cart")
                        } description: {
                            Text("Try adding some items to your list")
                        } actions: {
                            Button {
                                
                            } label: {
                                Text("Go to Pantry")
                            }
                        }
                    }
                }
                .navigationTitle("Grocery List")
                .navigationDestination(for: groceryListItem.self) { item in
                    ItemEditView(groceryItem: item.groceryItem)
                }
            }
        
    }
    
    func ChangeState(_ item: groceryListItem) {
        DeleteGroceryListItem(item)
    }
    
    func DeleteGroceryListItem(_ item: groceryListItem) {
        let results = groceryItems.filter {$0.name == item.groceryItem.name}
        results.first!.onlist = false
        context.delete(item)
    }
}

#Preview {
    ListView()
}
