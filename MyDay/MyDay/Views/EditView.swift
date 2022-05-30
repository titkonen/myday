import SwiftUI

struct EditView: View {
  @Environment(\.managedObjectContext) var managedObjContext
  @Environment(\.dismiss) var dismiss
  
  var day: FetchedResults<MyDayEntity>.Element
  
  @State private var title = ""
  @State private var breadtext = ""
  @State private var mood: Double = 0
  
  // MARK: Testing
//  let image: UIImage?
  @State private var image: UIImage?
//  @State var image:UIImage = UIImage()
  
  var body: some View {
    
    Form {
      Section {
        TextField("\(day.title!)", text: $title)
          .onAppear {
            title = day.title!
            breadtext = day.breadtext!
            mood = day.mood
          }
//        TextField("\(day.breadtext!)", text: $breadtext)
        TextEditor(text: $breadtext)
          .foregroundColor(.primary)
          .padding()
          .navigationTitle("My thoughts")
          .frame(height: 120)
        
        VStack {
          Text("Mood: \(Int(mood))")
          Slider(value: $mood, in: 0...90, step: 10)
        
//          image.map {
//            Image(uiImage: $0)
//              .renderingMode(.original)
//              .resizable()
//              .aspectRatio(contentMode: .fit)
//              .cornerRadius(8)
//              .shadow(radius: 10)
//          }
          
//          Image(uiImage: day.image?)
//          Image(uiImage: image)
          

          
        
        }
        VStack {
          Image(systemName: "plus")
//          image.map {
//            Image(uiImage: $0)
//          }
//          Image(uiImage: image)
//          Image(uiImage: image ?? UIImage())
          Image(uiImage: day.image?.uiImage ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fit)
//            .frame(width:100, height:200)
            .background(.gray)
          Image(systemName: "minus")
        }
        .padding()
        
        
        
        HStack {
          Spacer()
          Button("Update") {
            DataController().edit(day: day, title: title, breadtext: breadtext, mood: mood, context: managedObjContext, image: image)
            dismiss()
          }
          Spacer()
        }
      }
      
    }///_Form
  }///_Body
}///_Struct

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView()
//    }
//}
