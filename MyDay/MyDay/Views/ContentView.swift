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
  
  init() {
         //Use this if NavigationBarTitle is with Large Font
         UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemPurple]

         //Use this if NavigationBarTitle is with displayMode = .inline
         UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.systemPurple]
  
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithOpaqueBackground()
    coloredAppearance.backgroundColor = UIColor(red: 254/255, green: 241/255, blue: 214/255, alpha: 1)
    coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(red: 222/255, green: 150/255, blue: 167/255, alpha: 1)] /// UIColor(red: 220, green: 24, blue: 311, alpha: 1)
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 222/255, green: 150/255, blue: 167/255, alpha: 1)]
    
    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    
    UINavigationBar.appearance().tintColor = UIColor(red: 43/255, green: 101/255, blue: 134/255, alpha: 1) //NavBar link colors
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
                  Text("\(Int(day.mood))").foregroundColor(Color("secondary-color")) + Text(" Mood points")
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
//        .foregroundColor(Color("secondary-color"))
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
