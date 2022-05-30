import SwiftUI

struct DashboardView: View {
  @Environment(\.managedObjectContext) var managedObjContext
  @State private var title = ""
  @State var mood: Double = 0
  @State var color: Color = .gray
  
  @FetchRequest(sortDescriptors: [SortDescriptor(\.mood)]) var day: FetchedResults<MyDayEntity>
  
    var body: some View {
      NavigationView {
        List {
            ForEach(day) { day in
              VStack(alignment: .leading) {
                HStack(alignment: .top) {
                  Text(day.title ?? "Unknown name")
                    .onAppear {
                      mood = day.mood
                      title = day.title!
                    }
                  Spacer()
                  Text(calcTimeSince(date:day.date!))
                    .foregroundColor(.gray)
                    .font(.caption)
                    .italic()
                }///_HStack
                ZStack {
                  Rectangle()
                    .foregroundColor(colouredBars(mood:day.mood))
                    .frame(width: day.mood * 3, height: 15, alignment: .trailing)
                    .cornerRadius(5)
                  Text("\(Int(day.mood))")
                    .foregroundColor(.white)
                    .font(.caption)
                }///-ZStack
              }///-VStack
            }///ForEach Ends
        }///-List
        .navigationTitle("Charts")
      }
    } ///_Body
  
  func colouredBars(mood: Double) -> Color {
    if mood >= 60 {
      print("color green")
      return .green
    } else if mood >= 30 {
      print("color yellow")
      return .yellow
    } else {
      print("color red")
      return .red
    }
     return .clear
  }
  
  
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
