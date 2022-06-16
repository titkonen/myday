import SwiftUI

struct EditView: View {
  @Environment(\.managedObjectContext) var managedObjContext
  @Environment(\.dismiss) var dismiss
  
  var day: FetchedResults<MyDayEntity>.Element
  
  @State private var title = ""
  @State private var breadtext = ""
  @State private var mood: Double = 0
  
  // MARK: Image properties
  @State private var image: UIImage?
  @State private var shouldShowImagePicker = false
  
  var body: some View {
    VStack() {
      
      Form {
        Section {
          TextField("\(day.title!)", text: $title)
            .onAppear {
              title = day.title!
              breadtext = day.breadtext!
              mood = day.mood
            }
//          TextField("Notes", text: $breadtext)
          TextEditor(text: $breadtext)
            .foregroundColor(.primary)
//            .padding()
            .frame(height: 120)
          VStack {
            Text("My Mood today is: \(Int(mood))")
            Slider(value: $mood,in: 0...90, step: 10) {
              Text("Speed")
            } minimumValueLabel: {
              Text("Sad")
            } maximumValueLabel: {
              Text("Happy")
            }
            
          }
          .padding()
          HStack {
            Spacer()
            Button("Update") {
              DataController().edit(day: day, title: title, breadtext: breadtext, mood: mood, context: managedObjContext) /// image: image
              dismiss()
            }
            Spacer()
          }
        } ///_Section
          
        Section {
          VStack {
            Spacer()
            Image(uiImage: day.image?.uiImage ?? UIImage())
              .resizable()
              .aspectRatio(contentMode: .fit)
              .background(.gray)
              .cornerRadius(8)
  //            .shadow(radius: 10)
            Spacer()
          }///_VStack
            Button(
              action: {
                shouldShowImagePicker.toggle()
              },
              label: updatePhotoButton
            )
          HStack {
            Spacer()
            Button("Save Photo") {
              DataController().editPhoto(day: day, title: title, breadtext: breadtext, mood: mood, context: managedObjContext, image: image)
              dismiss()
            }
            Spacer()
          }
          
        }///_Section
      }///_Form
      .sheet(isPresented: $shouldShowImagePicker) {
        ImagePicker(image: $image)
      }
      .navigationTitle("My thoughts")
    } ///_VStack
    
  }///_Body
  
  @ViewBuilder
  private func updatePhotoButton() -> some View {
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
        Text("Update Photo")
        Spacer()
      }
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
  }
  
  
}///_Struct

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//      EditView(day: FetchedResults<MyDayEntity>.Element)
//    }
//}
