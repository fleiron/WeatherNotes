
import SwiftUI

struct CosmicBackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.black,
                    Color(red: 0.05, green: 0.05, blue: 0.2),
                    Color(red: 0.15, green: 0.0, blue: 0.3)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            Circle()
                .fill(Color.white.opacity(0.12))
                .blur(radius: 40)
                .frame(width: 220, height: 220)
                .offset(x: -140, y: -260)
            
            Circle()
                .fill(Color.purple.opacity(0.25))
                .blur(radius: 60)
                .frame(width: 260, height: 260)
                .offset(x: 160, y: 260)
            
            Circle()
                .strokeBorder(Color.white.opacity(0.06), lineWidth: 1.5)
                .frame(width: 300, height: 300)
                .offset(y: 180)
        }
    }
}
