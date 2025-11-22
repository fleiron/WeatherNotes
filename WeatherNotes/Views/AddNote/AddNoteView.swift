import SwiftUI

struct AddNoteView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: WeatherNotesViewModel
    
    @State private var text: String = ""
    @State private var isSaving: Bool = false
    
    var body: some View {
        ZStack {
            CosmicBackgroundView()
            
            VStack(spacing: 16) {
                Text("New WeatherNote")
                    .font(.custom("Rubik-Bold", size: 22))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.white.opacity(0.08))
                    )
                    .foregroundColor(.white)
                    .font(.custom("Rubik-Bold", size: 15))
                    .frame(minHeight: 140, maxHeight: 200)
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.custom("Rubik-Bold", size: 13))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                Button {
                    guard !isSaving else { return }
                    viewModel.clearError()
                    isSaving = true
                    Task {
                        await viewModel.addNote(with: text)
                        isSaving = false
                        if viewModel.errorMessage == nil {
                            dismiss()
                        }
                    }
                } label: {
                    HStack(spacing: 10) {
                        if isSaving || viewModel.isLoading {
                            ProgressView()
                                .tint(.black)
                        }
                        Text("Save")
                            .font(.custom("Rubik-Bold", size: 16))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.white)
                    )
                    .foregroundColor(.black)
                }
                .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isSaving)
                .padding(.top, 4)
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                    .font(.custom("Rubik-Bold", size: 14))
                    .foregroundColor(.white)
                }
            }
        }
    }
}
