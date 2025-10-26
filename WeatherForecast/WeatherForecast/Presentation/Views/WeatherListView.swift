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
        NavigationView {
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
                        //Background Image
                        BackgroundView(condition: days.first?.weather.first?.main ?? .clear)
                        VStack(alignment: .leading, spacing: 16) {
                            // Title
                            Text("5 Day Forecast")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.top, 16)
                                .padding(.leading, 16)
                            
                            // Divider Line
                            Rectangle()
                                .fill(Color.white.opacity(0.7))
                                .frame(height: 1)
                                .padding(.horizontal, 16)
                            
                            //Weather List
                            ScrollView {
                                LazyVStack(spacing: 16) {
                                    ForEach(days) { day in
                                        WeatherDayRowView(day: day)
                                            .padding(.horizontal)
                                    }
                                }
                            }
                        }
                    }
                case .failed(let error):
                    Text("Error: \(error)")
                }
            }
        }
        .navigationBarHidden(true)
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
