# WeatherNotes ☁️📝

Small demo app for iOS that combines **notes** with **current weather**.

When user adds a note (e.g. “Morning run”, “Walk in the park”), the app
fetches current weather for **Kyiv** via [WeatherAPI](https://www.weatherapi.com/)
and stores everything locally.

---

## Features

- ✏️ Add text note
- 🌡️ Auto-attach current temperature, condition and weather icon
- 🕒 Show creation date & time
- 📋 Notes list with text, time and compact weather info
- 🔍 Detail screen with:
  - full note text
  - formatted date/time
  - location name
  - temperature + condition + icon

---

## Tech stack

- 🧩 **SwiftUI**
- 🏛 **MVVM** (Models / ViewModels / Views / Services / Extensions)
- 🌐 **URLSession** + `WeatherService` (WeatherAPI)
- 💾 Local storage via **UserDefaults** + `Codable`
- 🎨 Custom UI:
  - dark / cosmic background
  - custom font **Rubik-Bold**

---
