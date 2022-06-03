import Foundation

struct Sorting: Hashable, Identifiable {
  
  let id: Int
  let title: String
  let descriptors: [SortDescriptor<MyDayEntity>]
  
  static let sorts: [Sorting] = [

    Sorting(
      id: 0,
      title: "Date | Ascending",
      // 3
      descriptors: [
        SortDescriptor(\MyDayEntity.date, order: .forward),
        SortDescriptor(\MyDayEntity.title, order: .forward)
      ]),
    Sorting(
      id: 1,
      title: "Date | Descending",
      descriptors: [
        SortDescriptor(\MyDayEntity.date, order: .reverse),
        SortDescriptor(\MyDayEntity.title, order: .forward)
      ]),
    Sorting(
      id: 2,
      title: "Mood | Ascending",
      descriptors: [
        SortDescriptor(\MyDayEntity.mood, order: .forward),
        SortDescriptor(\MyDayEntity.title, order: .forward)
      ]),
    Sorting(
      id: 3,
      title: "Mood | Descending",
      descriptors: [
        SortDescriptor(\MyDayEntity.mood, order: .reverse),
        SortDescriptor(\MyDayEntity.title, order: .forward)
      ])
  ]

  static var `default`: Sorting { sorts[1] }
  
}
