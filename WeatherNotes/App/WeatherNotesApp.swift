
import SwiftUI

@main
struct WeatherNotesApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherNotesRootView()
                .preferredColorScheme(.dark)
        }
    }
}
