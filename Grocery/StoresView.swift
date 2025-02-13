import SwiftData
import SwiftUI

struct StoresView: View {
    
    @Environment(\.modelContext) private var context
    @Query var Stores: [Store]
    
    @Binding var selectedStores: [Store]
    @State var newStore: String = ""
    
    var body: some View {
        List {
            ForEach(Stores) { store in
                HStack {
                    Text(store.name)
                    Spacer()
                    if selectedStores.contains(store) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .onTapGesture {
                    if let index = selectedStores.firstIndex(of: store) {
                        selectedStores.remove(at: index)
                    } else {
                        selectedStores.append(store)
                    }
                }
            }
            .onDelete(perform: DeleteStore)
            HStack {
                TextField(text: $newStore) {
                    Text("New Store")
                }
                Button {
                    let newStoreItem = Store(name: newStore)
                    context.insert(newStoreItem)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func DeleteStore(offsets: IndexSet) {
        for index in offsets {
            let item = Stores[index]
            context.delete(item)
        }
    }
}

#Preview {
    @Previewable @State var selectedStores: [Store] = [.init(name: "Target"), .init(name: "Walmart"), .init(name: "IGA")]
    StoresView(selectedStores: $selectedStores)
}
