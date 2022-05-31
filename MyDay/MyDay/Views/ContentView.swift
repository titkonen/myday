import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) var managedObjContext
//  @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var day: FetchedResults<MyDayEntity>
  @FetchRequest(sortDescriptors: Sorting.default.descriptors) var day: FetchedResults<MyDayEntity>
  @State private var showingAddView = false
  
  @State private var selectedSort = Sorting.default

  // MARK: Search function
  @State private var searchText = ""
  
    var body: some View {
      NavigationView {
        
        List {
          ForEach(day) { day in
            NavigationLink(destination: EditView(day: day)) { /// , image: day.image?.uiImage
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
//        .searchable(text: searchQuery)
        .searchable(text: $searchText, prompt: "Look for something")
        .listStyle(.plain)
        .navigationTitle("Day List")
        .toolbar {
  
          ToolbarItemGroup(placement: .navigationBarTrailing) {
            
            SortSelectionView(
                selectedSortItem: $selectedSort,
                sorts: Sorting.sorts)
              .onChange(of: selectedSort) { _ in
                day.sortDescriptors = selectedSort.descriptors
              }
            
            Button {
              showingAddView.toggle()
            } label: {
              Label("Add Day", systemImage: "plus.circle")
            }
          }
          
          
//          ToolbarItem(placement: .navigationBarTrailing) {
//            Button {
//              showingAddView.toggle()
//            } label: {
//              Label("Add Day", systemImage: "plus.circle")
//            }
//          }
          
          
          ToolbarItem(placement: .navigationBarLeading) {
            EditButton()
          }
          
          
        } ///_Toolbar
        .sheet(isPresented: $showingAddView) {
          AddView()
        }
      }///-NavigationView
      .navigationViewStyle(.stack)
    } ///_Body
  
//  var searchResults: [String] {
//      if searchText.isEmpty {
//        return day
//      } else {
//          return names.filter { $0.contains(searchText) }
//      }
//  }
  
  private func deleteDay(offsets: IndexSet) {
    withAnimation {
      offsets.map { day[$0] }.forEach(managedObjContext.delete)
      DataController().save(context: managedObjContext)
    }
  }
  
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//      ContentView(day.image?.uiImage)
//    }
//}
