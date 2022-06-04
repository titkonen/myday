import SwiftUI

struct SettingsView: View {
  @State var dailyReminderEnabled = false
  @State var dailyReminderTime = Date(timeIntervalSince1970: 0)
  @AppStorage("appearance") var appearance: Appearance = .automatic
  
    var body: some View {
      NavigationView {
        List {
          Section(header: Text("Appearance")) {
            VStack(alignment: .leading) {
              Picker("", selection: $appearance) {
                ForEach(Appearance.allCases) { appearance in
                  Text(appearance.name).tag(appearance)
                }          }
              .pickerStyle(SegmentedPickerStyle())
            }
          }
          Section(header: Text("Notifications and privacy policy")) {
            HStack {
              if #available(iOS 14.0, *) {
                Toggle("Daily Reminder", isOn: $dailyReminderEnabled)
                  .onChange(
                    of: dailyReminderEnabled,
                    perform: { _ in configureNotification() }
                  )
              } else {
                // Fallback on earlier versions
              }
              if #available(iOS 14.0, *) {
                DatePicker(
                  "",
                  selection: $dailyReminderTime,
                  displayedComponents: .hourAndMinute
                )
                  .disabled(dailyReminderEnabled == false)
                  .onChange(
                    of: dailyReminderTime,
                    perform: { _ in configureNotification() }
                  )
              } else {
                // Fallback on earlier versions
              }
            } /// _Hstack
            NavigationLink(destination: PrivacyPolicyView()) {
              Text("Privacy Policy")
                .foregroundColor(.orange)
            }
            
          }
        }
        .navigationTitle("Settings")
      }
    }
  
  func configureNotification() {
    if dailyReminderEnabled {
      LocalNotifications.shared.createReminder(
        time: dailyReminderTime)
    } else {
      LocalNotifications.shared.deleteReminder()
    }
  }
  
} ///_Struct

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
