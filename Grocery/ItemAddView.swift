import SwiftUI
import SwiftData

struct ItemAddView: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @Query var items: [groceryItem]
    
    @State private var name: String = ""
    @State var selectedStores: [Store] = []
    
    var body: some View {
        NavigationStack {
            List {
                TextField(text: $name) {
                    Text("Item Name")
                }
                NavigationLink(destination: StoresView(selectedStores: $selectedStores)) {
                    Text("Stores")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let results = items.filter {$0.name == name}
                        if results.isEmpty {
                            let newItem = groceryItem(name: name, stores: selectedStores)
                            addItem(item: newItem)
                            dismiss()
                        }
                    } label: {
                        Text("Done")
                    }
                }
            }
            .navigationTitle("Add Item")
        }
    }
    
    public func addItem(item: groceryItem) {
        context.insert(item)
    }
}

#Preview {
    ItemAddView()
}
