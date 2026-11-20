import SwiftUI

@main
struct MakiAndinoApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .tint(Theme.primario)
        }
    }
}
