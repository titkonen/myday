
import SwiftUI

@main
struct MyDayApp: App {
  
  // Injecting
  @StateObject private var dataController = DataController()
  
    var body: some Scene {
        WindowGroup {
            ContentView()
            ///Injecting environment
            .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
