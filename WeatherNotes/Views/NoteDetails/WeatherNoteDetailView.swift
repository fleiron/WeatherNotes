import SwiftUI

struct WeatherNoteDetailView: View {
    let note: WeatherNote
    
    var body: some View {
        ZStack {
            CosmicBackgroundView()
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    VStack(spacing: 16) {
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
                            .frame(width: 90, height: 90)
                            .padding(10)
                            .background(
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Color.white.opacity(0.22),
                                                Color.white.opacity(0.05)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            )
                            .shadow(color: .black.opacity(0.6), radius: 14, x: 0, y: 8)
                        } else {
                            Image(systemName: "cloud.sun.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [
                                                    Color.white.opacity(0.22),
                                                    Color.white.opacity(0.05)
                                                ],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                )
                                .shadow(color: .black.opacity(0.6), radius: 14, x: 0, y: 8)
                        }
                        
                        VStack(spacing: 4) {
                            Text(note.locationName)
                                .font(.custom("Rubik-Bold", size: 20))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            Text(note.createdAt.formattedLong())
                                .font(.custom("Rubik-Bold", size: 13))
                                .foregroundColor(.white.opacity(0.65))
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 16)
                    
                   
                    VStack(spacing: 10) {
                        Text("Note")
                            .font(.custom("Rubik-Bold", size: 16))
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                        
                        Text(note.text)
                            .font(.custom("Rubik-Bold", size: 17))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Color.white.opacity(0.10),
                                                Color.black.opacity(0.40)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(
                                                LinearGradient(
                                                    colors: [
                                                        Color.white.opacity(0.35),
                                                        Color.white.opacity(0.06)
                                                    ],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                lineWidth: 0.8
                                            )
                                    )
                            )
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 4)
                    
             
                    VStack(spacing: 10) {
                        Text("Weather")
                            .font(.custom("Rubik-Bold", size: 16))
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                        
                        VStack(spacing: 8) {
                            Text("\(Int(note.temperatureC.rounded()))°C")
                                .font(.custom("Rubik-Bold", size: 36))
                                .foregroundColor(.white)
                            
                            Text(note.conditionText)
                                .font(.custom("Rubik-Bold", size: 16))
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.vertical, 16)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.white.opacity(0.12),
                                            Color.black.opacity(0.45)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(
                                            LinearGradient(
                                                colors: [
                                                    Color.white.opacity(0.35),
                                                    Color.white.opacity(0.05)
                                                ],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 0.8
                                        )
                                )
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 4)
                    
                    Spacer(minLength: 32)
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                .padding(.bottom, 32)
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
