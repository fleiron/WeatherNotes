import SwiftUI

struct WeatherNotesRootView: View {
    @StateObject private var viewModel = WeatherNotesViewModel()
    @State private var isShowingAddNote: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                CosmicBackgroundView()
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(.custom("Rubik-Bold", size: 14))
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.black.opacity(0.55))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14)
                                            .stroke(Color.red.opacity(0.6), lineWidth: 1)
                                    )
                            )
                            .padding(.top, 4)
                    }
                    
                    Group {
                        if viewModel.notes.isEmpty {
                           
                            Spacer(minLength: 0)
                            
                            VStack(spacing: 14) {
                                Image(systemName: "cloud.sun.rain.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white.opacity(0.9))
                                    .shadow(radius: 8)
                                
                                Text("No notes yet")
                                    .font(.custom("Rubik-Bold", size: 22))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                
                                Text("Tap + to add your first WeatherNote.")
                                    .font(.custom("Rubik-Bold", size: 14))
                                    .foregroundColor(.white.opacity(0.7))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 40)
                            }
                            .padding(.vertical, 32)
                            .padding(.horizontal, 24)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color.black.opacity(0.45))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(
                                                LinearGradient(
                                                    colors: [
                                                        Color.white.opacity(0.3),
                                                        Color.white.opacity(0.05)
                                                    ],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                lineWidth: 1
                                            )
                                    )
                                    .shadow(color: .black.opacity(0.6), radius: 22, x: 0, y: 10)
                            )
                            
                            Spacer(minLength: 0)
                        } else {
                           
                            ScrollView {
                                LazyVStack(spacing: 12) {
                                    ForEach(viewModel.notes) { note in
                                        NavigationLink {
                                            WeatherNoteDetailView(note: note)
                                        } label: {
                                            WeatherNoteRowView(note: note)
                                        }
                                        .buttonStyle(.plain)
                                        .contextMenu {
                                            Button(role: .destructive) {
                                                viewModel.deleteNote(note)
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        }
                                    }
                                }
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(
                                            LinearGradient(
                                                colors: [
                                                    Color.white.opacity(0.12),
                                                    Color.black.opacity(0.35)
                                                ],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .blur(radius: 0.5)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 24)
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
                                        .shadow(color: .black.opacity(0.55), radius: 20, x: 0, y: 10)
                                )
                                .padding(.horizontal, 4)
                                .padding(.top, 4)
                                .padding(.bottom, 8)
                            }
                            .scrollIndicators(.hidden)
                        }
                    }
                }
                .padding()
                
           
                if viewModel.isLoading {
                    ZStack {
                        Color.black.opacity(0.45)
                            .ignoresSafeArea()
                        
                        VStack(spacing: 10) {
                            ProgressView()
                                .progressViewStyle(.circular)
                            
                            Text("Loading weather...")
                                .font(.custom("Rubik-Bold", size: 14))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.black.opacity(0.8))
                        )
                        .shadow(color: .black.opacity(0.6), radius: 20, x: 0, y: 8)
                    }
                    .transition(.opacity)
                    .zIndex(1)
                }
            }
            .navigationTitle("WeatherNotes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.clearError()
                        isShowingAddNote = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .symbolRenderingMode(.hierarchical)
                    }
                    .tint(.white)
                }
            }
            .sheet(isPresented: $isShowingAddNote) {
                AddNoteView(viewModel: viewModel)
                    .preferredColorScheme(.dark)
            }
        }
    }
}
