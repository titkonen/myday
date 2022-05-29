import Foundation
import CoreData

class DataController: ObservableObject {
  let container = NSPersistentContainer(name: "MyDayModel")
  
  init() {
    container.loadPersistentStores { desc, error in
      if let error = error {
        print("Failed to load the data \(error.localizedDescription)")
      }
    }
  }
  
  func save(context: NSManagedObjectContext) {
    do {
      try context.save()
      print("Data saved")
    } catch {
      print("Couldn't save the data")
    }
  }
  
  func add(title: String, breadtext: String, mood: Double, context: NSManagedObjectContext) {
    let day = MyDayEntity(context: context)
    day.id = UUID()
    day.date = Date()
    day.title = title
    day.breadtext = breadtext
    day.mood = mood
    
    save(context: context)
  }
  
  func edit(day: MyDayEntity, title: String, breadtext: String, mood: Double, context: NSManagedObjectContext) {
    day.date = Date()
    day.title = title
    day.breadtext = breadtext
    day.mood = mood
    
    save(context: context)
  }
  
}
