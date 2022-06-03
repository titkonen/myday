import SwiftUI

@main
struct MyDayApp: App {
  
  // Injecting
  @StateObject private var dataController = DataController()
  
  // Appearance
  @AppStorage("appearance") var appearance: Appearance = .automatic
  
    var body: some Scene {
        WindowGroup {
          TabBarView()
            ///Injecting environment
            .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
