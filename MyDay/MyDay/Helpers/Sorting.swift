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
      ])
//    Sorting(
//      id: 2,
//      name: "Meeting Date | Ascending",
//      descriptors: [
//        SortDescriptor(\Friend.meetingDate, order: .forward),
//        SortDescriptor(\Friend.name, order: .forward)
//      ]),
//    Sorting(
//      id: 3,
//      name: "Meeting Date | Descending",
//      descriptors: [
//        SortDescriptor(\Friend.meetingDate, order: .reverse),
//        SortDescriptor(\Friend.name, order: .forward)
//      ])
  ]

  // 4
  static var `default`: Sorting { sorts[0] }
  
  
}
