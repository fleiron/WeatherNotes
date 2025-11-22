


import Foundation
import Combine

@MainActor
final class WeatherNotesViewModel: ObservableObject {
    @Published var notes: [WeatherNote] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let storageKey = "weather_notes_v1"
    private let weatherService: WeatherService
    
    init(weatherService: WeatherService = .shared) {
        self.weatherService = weatherService
        loadFromStorage()
    }
    
    private func loadFromStorage() {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: storageKey) else { return }
        
        do {
            let decoded = try JSONDecoder().decode([WeatherNote].self, from: data)
            self.notes = decoded
        } catch {
            print("Failed to decode notes from UserDefaults: \(error)")
        }
    }
    
    private func saveToStorage() {
        let defaults = UserDefaults.standard
        
        do {
            let data = try JSONEncoder().encode(notes)
            defaults.set(data, forKey: storageKey)
        } catch {
            print("Failed to encode notes to UserDefaults: \(error)")
        }
    }
    
    func clearError() {
        errorMessage = nil
    }
    
    func deleteNote(_ note: WeatherNote) {
        if let index = notes.firstIndex(of: note) {
            notes.remove(at: index)
            saveToStorage()
        }
    }
    
    func addNote(with text: String) async {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Please enter some text."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let weather = try await weatherService.fetchCurrentWeather(for: "Kyiv")
            
            let note = WeatherNote(
                id: UUID(),
                text: text,
                createdAt: Date(),
                temperatureC: weather.current.tempC,
                conditionText: weather.current.condition.text,
                iconURL: weather.current.condition.icon,
                locationName: "\(weather.location.name), \(weather.location.country)"
            )
            
            notes.insert(note, at: 0)
            saveToStorage()
        } catch {
            if let err = error as? LocalizedError,
               let desc = err.errorDescription {
                errorMessage = desc
            } else {
                errorMessage = "Failed to fetch weather."
            }
        }
        
        isLoading = false
    }
}
