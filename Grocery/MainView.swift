import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var context
    @Query var items: [groceryItem]
    
    var body: some View {
        TabView {
            PantryView()
                .tabItem {
                    Label("Pantry", systemImage: "cabinet")
                }
            ListView()
                .tabItem {
                    Label("Shopping List", systemImage: "list.bullet")
                }
            
        }
    }
}

#Preview {
    MainView()
}
