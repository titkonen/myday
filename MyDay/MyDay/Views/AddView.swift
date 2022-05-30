import SwiftUI

struct AddView: View {
  @Environment(\.managedObjectContext) var managedObjContext
  @Environment(\.dismiss) var dismiss
  
  @State private var title = ""
  @State private var breadtext = "Add thoughts"
  @State private var mood: Double = 50
  @State private var image: UIImage?
  @State private var shouldShowImagePicker = false
  
  //MARK: For testing
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
            Slider(value: $mood,in: 0...90, step: 10) {
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
          
        }///_Section
        Section {
          Button(
            action: {
              shouldShowImagePicker.toggle()
            },
            label: makeImageForChoosePhotosButton
          )
        }
        
        HStack {
          Spacer()
          Button("Save") {
            guard let image = image else { return }
            DataController().add(title: title, breadtext: breadtext, mood: mood, context: managedObjContext, image: image)
            dismiss()
          }
          Spacer()
        }///_HStack
        
      } ///_Form
      .sheet(isPresented: $shouldShowImagePicker) {
        ImagePicker(image: $image)
      }
      
    } ///_Body
  
  @ViewBuilder
  private func makeImageForChoosePhotosButton() -> some View {
    image.map {
      Image(uiImage: $0)
        .renderingMode(.original)
        .resizable()
        .aspectRatio(contentMode: .fill)
    }

    if image == nil {
      HStack {
        Spacer()
        Image(systemName: "photo.on.rectangle")
        Text("Choose Photo")
        Spacer()
      }
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
  }
  
}///_Struct

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
