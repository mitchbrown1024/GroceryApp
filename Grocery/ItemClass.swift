import SwiftData
import Foundation

@Model
class groceryItem: Identifiable {
    var name: String
    var id: String
    var stores: [Store]
    var aisle: String?
    var onlist: Bool
    
    init(name: String, stores: [Store]) {
        self.id = UUID().uuidString
        self.name = name
        self.stores = stores
        self.aisle = nil
        self.onlist = false
    }
}

@Model
class groceryListItem: Identifiable {
    var id: String
    var groceryItem: groceryItem
    
    init(item: groceryItem) {
        self.id = UUID().uuidString
        self.groceryItem = item
    }

}

@Model
class Store: Identifiable {
    var id: String
    var name: String
    
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
    }
}
