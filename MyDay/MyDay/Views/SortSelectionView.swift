import SwiftUI

struct SortSelectionView: View {

  @Binding var selectedSortItem: Sorting
  let sorts: [Sorting]

    var body: some View {

      Menu {
        Picker("Sort By", selection: $selectedSortItem) {
          ForEach(sorts, id: \.self) { sort in
            Text("\(sort.title)")
          }
        }
      } label: {
        Label(
          "Sort",
          systemImage: "line.horizontal.3.decrease.circle")
      }
      .pickerStyle(.inline)

      
    }
}

struct SortSelectionView_Previews: PreviewProvider {
  
  @State static var sort = Sorting.default

    static var previews: some View {
      SortSelectionView(
        selectedSortItem: $sort,
        sorts: Sorting.sorts)

    }
}
