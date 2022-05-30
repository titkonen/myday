import Foundation
import CoreData
import UIKit

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
  
  func add(title: String, breadtext: String, mood: Double, context: NSManagedObjectContext, image: UIImage?) {
    let day = MyDayEntity(context: context)
    day.id = UUID()
    day.date = Date()
    day.title = title
    day.breadtext = breadtext
    day.mood = mood
    day.image = image?.pngData()
    
    
    save(context: context)
  }
  
  func edit(day: MyDayEntity, title: String, breadtext: String, mood: Double, context: NSManagedObjectContext) {
    day.date = Date()
    day.title = title
    day.breadtext = breadtext
    day.mood = mood
//    day.image = image?.pngData()
    
    save(context: context)
  }
  
  func editPhoto(day: MyDayEntity, title: String, breadtext: String, mood: Double, context: NSManagedObjectContext, image: UIImage?) {
    day.date = Date()
    day.title = title
    day.breadtext = breadtext
    day.mood = mood
    day.image = image?.pngData()
    
    save(context: context)
  }
  
}
