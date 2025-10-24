//
//  WeatherForecastApp.swift
//  WeatherForecast
//
//  Created by Drashti Lakhani on 10/24/25.
//

import SwiftUI

@main
struct WeatherForecastApp: App {
    // Hold the view model as a StateObject so it's created once per app lifecycle
    @StateObject private var viewModel: WeatherListViewModel

    init() {
        // Load API key from Config.plist
        let apiKey: String = {
            guard let filePath = Bundle.main.path(forResource: "Config", ofType: "plist"),
                  let plist = NSDictionary(contentsOfFile: filePath),
                  let key = plist["OPENWEATHER_API_KEY"] as? String else {
                fatalError("Missing OPENWEATHER_API_KEY in Config.plist")
            }
            return key
        }()
        // Initialize dependencies
        let client = NetworkClient()
        let openWeatherAPI = OpenWeatherAPI(
            apiKey: apiKey,
            client: client
        )
        let repo = WeatherRepositoryImpl(api: openWeatherAPI)

        // IMPORTANT: Initialize the backing storage `_viewModel` with a StateObject
        _viewModel = StateObject(wrappedValue: WeatherListViewModel(repo: repo, locationManager: LocationManager()))
    }

    var body: some Scene {
        WindowGroup {
            // Pass the view model into the root view
            WeatherListView(viewModel: viewModel)
        }
    }
}
