import SwiftUI

struct TabBarView: View {
  @AppStorage("appearance") var appearance: Appearance = .automatic
  
    var body: some View {
      TabView {
        ContentView()
          .tabItem({
            VStack {
              Image(systemName: "list.bullet")
              Text("My Days")
            }
          })
          .tag(0)
          .preferredColorScheme(appearance.getColorScheme())
        
        DashboardView()
            .tabItem({
              VStack {
                Image(systemName: "chart.bar.doc.horizontal")
                Text("Dashboard")
              }
            })
            .tag(1)
        
        SettingsView()
            .tabItem({
              VStack {
                Image(systemName: "gearshape.fill")
                Text("Settings")
              }
            })
            .tag(2)
      }
      .accentColor(Color("primary-orange"))
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
      TabBarView()
    }
}
