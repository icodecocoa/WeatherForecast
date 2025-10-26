# 🌤️ WeatherForecast

A **SwiftUI-based iOS app** that displays a **5-day weather forecast** using live API data.  
Built with **MVVM architecture**, **async/await**, and **dependency injection** to ensure clean, modular, and reactive design.

---

## 🧠 Overview

WeatherForecast provides a simple, elegant interface for viewing upcoming weather conditions.  
It demonstrates modern iOS development practices, including:

- ✅ SwiftUI views powered by **MVVM**
- 🌍 Real-time weather data fetched from a live **OpenWeather API**
- ⚡ Swift **Concurrency (async/await)** for smooth async operations
- 🧩 **Dependency Injection** for modularity and testability
- 🧪 **Unit and UI Testing** with XCTest/XCUITest
- 🧱 Clean architecture with separation of concerns

---

## 🧰 Tech Stack

| Layer | Technologies Used |
|-------|--------------------|
| **UI** | SwiftUI, Combine |
| **Architecture** | MVVM (Model-View-ViewModel) |
| **Networking** | URLSession, async/await |
| **Data Handling** | Codable, Result Types |
| **Location Services** | CoreLocation |
| **Testing** | XCTest, XCUITest, Mocks |
| **CI/CD** | GitHub Actions (Build + Test + Archive) |

---

## 🧩 Architecture

```
WeatherForecast
├── App
├── Data
│   ├── Networking
├── Domain
│   ├── Models
│   ├── Repositories
├── Presentation
│   ├── Assets
│   ├── Views
│   ├── ViewModels
├── Core
│   ├── Config
│   ├── Location
│   ├── Utilities
├── WeatherForecastTests
│   ├── Mocks
```

---

## 🚀 Features

- 🌦 Displays 5-day forecast by location  
- 📍 Uses device GPS via CoreLocation  
- 🖼 Dynamic background based on weather (Sunny, Cloudy, Rainy)  
- 🔄 Refresh forecast when location changes  
- 📱 Adaptive layout for iPhone and iPad  
- 🧪 Comprehensive unit test coverage  

---

## ⚙️ Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/icodecocoa/WeatherForecast.git
   ```

2. Open the project in Xcode:
   ```bash
   open WeatherForecast.xcodeproj
   ```

3. Add your API key to `Config.plist`:
   ```xml
   <key>OPENWEATHER_API_KEY</key>
   <string>YOUR_API_KEY_HERE</string>
   ```

4. Run the app on iOS Simulator or device:
   ```bash
   ⌘ + R
   ```

---

## 🧪 Running Tests

To run unit and UI tests:

```bash
xcodebuild test   -project WeatherForecast.xcodeproj   -scheme "WeatherForecast"   -destination 'platform=iOS Simulator,name=iPhone 15'
```

All tests are located in the `WeatherForecastTests` target.

---

## 🔁 CI/CD Pipeline

WeatherForecast uses **GitHub Actions** for continuous integration:

- Automatically builds and tests the app on **macOS runners**
- Runs **SwiftLint** for static analysis
- Archives successful builds from the `main` branch

> See `.github/workflows/ci.yml` for details.

---

## 👩‍💻 Author

**Drashti Lakhani**  
Senior iOS Developer  
[LinkedIn](https://www.linkedin.com/in/drashti-lakhani) · [GitHub](https://github.com/icodecocoa)
