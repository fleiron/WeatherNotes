


import SwiftUI

struct WeatherNoteRowView: View {
    let note: WeatherNote
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let urlString = note.iconURL,
               let url = URL(string: "https:\(urlString)") {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure:
                        Image(systemName: "cloud.sun.fill")
                            .resizable()
                            .scaledToFit()
                    @unknown default:
                        Image(systemName: "cloud.sun.fill")
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(width: 44, height: 44)
            } else {
                Image(systemName: "cloud.sun.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(note.text)
                    .font(.custom("Rubik-Bold", size: 16))
                    .foregroundColor(.white)
                    .lineLimit(2)
                
                Text(note.locationName)
                    .font(.custom("Rubik-Bold", size: 12))
                    .foregroundColor(.white.opacity(0.7))
                
                HStack(spacing: 8) {
                    Text(note.createdAt.formattedShort())
                        .font(.custom("Rubik-Bold", size: 11))
                        .foregroundColor(.white.opacity(0.5))
                    
                    Divider()
                        .frame(height: 10)
                        .background(Color.white.opacity(0.25))
                    
                    Text("\(Int(note.temperatureC.rounded()))°C")
                        .font(.custom("Rubik-Bold", size: 13))
                        .foregroundColor(.white.opacity(0.9))
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white.opacity(0.4))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.06),
                            Color.white.opacity(0.02)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.white.opacity(0.12), lineWidth: 1)
        )
    }
}
