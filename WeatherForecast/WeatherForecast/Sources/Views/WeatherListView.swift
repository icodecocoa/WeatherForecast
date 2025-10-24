//
//  WeatherListView.swift
//  WeatherForecast
//
//  Created by Drashti Lakhani on 10/24/25.
//

import SwiftUI

struct WeatherListView: View {
    @StateObject var viewModel: WeatherListViewModel
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .idle:
                Button("Tap to load weather") {
                    Task {
                        await viewModel.fetchWeather()
                    }
                }
            case .loading:
                ProgressView()
            case .loaded(let days):
                ZStack {
                    BackgroundView(condition: days.first?.weather.first?.main ?? .clear)
                }
            case .failed(let error):
                Text("Error: \(error)")
            }
        }
        .onAppear() {
            Task {
                await viewModel.fetchWeather()
            }
        }
    }
}

struct BackgroundView: View {
    let condition: MainEnum
    var body: some View {
        // simple mapping
        var name: String {
            switch condition {
            case .clear:
                return "Sunny"
            case .clouds:
                return "Cloudy"
            case .rain, .drizzle:
                return "Rainy"
            case .snow, .ash, .dust, .fog, .haze, .mist, .smoke, .tornado, .thunderstorm, .sand, .squall:
                return "Forest"
            }
        }
        GeometryReader { proxy in
            Image(name)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}
