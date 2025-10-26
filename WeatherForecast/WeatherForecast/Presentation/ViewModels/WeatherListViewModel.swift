//
//  WeatherListViewModel.swift
//  WeatherForecast
//
//  Created by Drashti Lakhani on 10/24/25.
//

import Foundation
import CoreLocation
import Combine

@MainActor
final class WeatherListViewModel: ObservableObject {
    enum State {
        case idle, loading, loaded([ForecastItem]), failed(String)
    }
    
    @Published private(set) var state: State = .idle
    private let repo: WeatherRepository
    private let locationManager: LocationManager
    
    init(repo: WeatherRepository, locationManager: LocationManager) {
        self.repo = repo
        self.locationManager = locationManager
    }
    
    func fetchWeather() async {
        self.state = .loading
        do {
            let coordinates = try await locationManager.requestLocation()
            let days = try await repo.fetchFiveDayForecast(lat: coordinates.latitude, lon: coordinates.longitude)
            state = .loaded(days)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}

