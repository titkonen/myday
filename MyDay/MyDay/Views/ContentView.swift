import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) var managedObjContext
  @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var day: FetchedResults<MyDayEntity>
  
  @State private var showingAddView = false
  
    var body: some View {
      NavigationView {
        List {
          ForEach(day) { day in
            NavigationLink(destination: EditView(day: day)) {
              HStack {
                VStack(alignment: .leading, spacing: 6) {
                  Text(day.title!)
                    .bold()
                  
                  Text("\(Int(day.mood))") + Text(" Mood points")
                    .foregroundColor(.gray)
                    .font(.callout)
                }
                Spacer()
                Text(calcTimeSince(date:day.date!))
                  .foregroundColor(.gray)
                  .font(.callout)
                
              }///_Hstack
            }
          }///_ForEach
          .onDelete(perform: deleteDay)
        }///-List
        .listStyle(.plain)
        .navigationTitle("Day List")
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              showingAddView.toggle()
            } label: {
              Label("Add Day", systemImage: "plus.circle")
            }
          }
          ToolbarItem(placement: .navigationBarLeading) {
            EditButton()
          }
        }
        .sheet(isPresented: $showingAddView) {
          AddView()
        }
      }///-NavigationView
      .navigationViewStyle(.stack)
      
      
    }///-Body
  
  private func deleteDay(offsets: IndexSet) {
    withAnimation {
      offsets.map { day[$0] }.forEach(managedObjContext.delete)
      DataController().save(context: managedObjContext)
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
