import SwiftUI

struct AddView: View {
  @Environment(\.managedObjectContext) var managedObjContext
  @Environment(\.dismiss) var dismiss
  
  @State private var title = ""
  @State private var breadtext = ""
  @State private var mood: Double = 0
  
    var body: some View {
      Form {
        Section {
          TextField("Title", text: $title)
          TextField("Breadtext", text: $breadtext)
          
          VStack {
            Text("Mood \(Int(mood))")
            Slider(value: $mood, in: 0...90, step: 10)
          }
          .padding()
          
          HStack {
            Spacer()
            Button("Save") {
              DataController().add(title: title, breadtext: breadtext, mood: mood, context: managedObjContext)
              dismiss()
            }
            Spacer()
          }
          
        }
      } ///-form
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
