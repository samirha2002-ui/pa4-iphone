import SwiftUI

@main
struct FuegoAndinoApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .tint(Theme.primario)
        }
    }
}
