import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) var managedObjContext
//  @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var day: FetchedResults<MyDayEntity>
  @FetchRequest(sortDescriptors: Sorting.default.descriptors) var day: FetchedResults<MyDayEntity>
  @State private var showingAddView = false
  @State private var selectedSort = Sorting.default
  @State private var image: UIImage?
  @State private var searchTerm = ""
  
  var searchQuery: Binding<String> {
    Binding {
      searchTerm
    } set: { newValue in
      searchTerm = newValue
      guard !newValue.isEmpty else {
        day.nsPredicate = nil
        return
      }
      day.nsPredicate = NSPredicate(
        format: "title contains[cd] %@", //
        newValue)
    }
  }

    var body: some View {
      NavigationView {
        List {
          ForEach(day) { day in
            NavigationLink(destination: EditView(day: day)) { /// , image: day.image?.uiImage
              HStack {
                Image(uiImage: day.image?.uiImage ?? UIImage())
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .background(.gray)
                  .frame(width: 54, height: 54)
                  .cornerRadius(6)
                VStack(alignment: .leading, spacing: 6) {
                  Text(day.title!)
                    .bold()
                  Text("\(Int(day.mood))").foregroundColor(.orange) + Text(" Mood points")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                }
                Spacer()
                Text(" \(day.date!.formatted(date: .abbreviated, time: .omitted))")
                  .foregroundColor(.gray)
                  .font(.footnote)
              } ///_Hstack
            } ///_NavLink
          } ///_ForEach
          .onDelete(perform: deleteDay)
        }///-List
        .searchable(text: searchQuery)
        .listStyle(.plain)
        .navigationTitle("My Days")
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
          } ///_ToolbarItemGroup
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
    
  private func deleteDay(offsets: IndexSet) {
    withAnimation {
      offsets.map { day[$0] }.forEach(managedObjContext.delete)
      DataController().save(context: managedObjContext)
    }
  }
  
} ///_Struct

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//      ContentView(day.image?.uiImage)
//    }
//}
