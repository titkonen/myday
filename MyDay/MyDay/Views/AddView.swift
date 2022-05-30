import SwiftUI

struct AddView: View {
  @Environment(\.managedObjectContext) var managedObjContext
  @Environment(\.dismiss) var dismiss
  
  @State private var title = ""
  @State private var breadtext = "My thoughts"
  @State private var mood: Double = 50
  
  @State private var speed = 50.0
  @State private var isEditing = false
  
    var body: some View {
      Form {
        Section {
          TextField("Title", text: $title)
//          TextField("Breadtext", text: $breadtext)
          TextEditor(text: $breadtext)
            .foregroundColor(.primary)
//            .foregroundColor(isEditing ? .red : .blue)
            .padding()
            .navigationTitle("My thoughts")
            .frame(height: 120)
          
//        onEditingChanged: { editing in
//          isEditing = editing
//        }
          
          
          
          VStack {
            Text("My Mood today is: \(Int(mood))")
//            Slider(value: $mood, in: 0...90, step: 10)
            
            Slider(
              value: $mood,
              in: 0...90,
              step: 10
            ) {
              Text("Speed")
            } minimumValueLabel: {
              Text("Sad")
//              Image(systemName: "pencil.circle")
            } maximumValueLabel: {
              Text("Happy")
            } onEditingChanged: { editing in
              isEditing = editing
            }
//            Text("\(speed)")
//              .foregroundColor(isEditing ? .red : .blue)
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
