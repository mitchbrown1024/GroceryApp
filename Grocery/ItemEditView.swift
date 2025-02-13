import SwiftUI

struct ItemEditView: View {
    var groceryItem: groceryItem
    
    var body: some View {
        Text(groceryItem.name)
    }
}
