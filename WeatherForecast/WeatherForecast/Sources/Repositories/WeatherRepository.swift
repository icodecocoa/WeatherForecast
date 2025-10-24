//
//  WeatherRepository.swift
//  WeatherForecast
//
//  Created by Drashti Lakhani on 10/24/25.
//

import Foundation

protocol WeatherRepository {
    func fetchFiveDayForecast(lat: Double, lon: Double) async throws -> [ForecastItem]
}

final class WeatherRepositoryImpl: WeatherRepository {
    private let api: OpenWeatherAPI
    
    init(api: OpenWeatherAPI) {
        self.api = api
    }
    
    func fetchFiveDayForecast(lat: Double, lon: Double) async throws -> [ForecastItem] {
            let resp = try await api.fetchFiveDayForecast(forLatitude: lat, andLongitude: lon)
            // OpenWeatherMap returns data every 3 hours — pick one item per day (e.g., 12:00)
            let calendar = Calendar.current
            let grouped = Dictionary(grouping: resp.list) { item -> Date in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                if let date = dateFormatter.date(from: item.dtTxt) {
                    return calendar.startOfDay(for: date)
                } else {
                    let date = Date(timeIntervalSince1970: TimeInterval(item.dt))
                    return calendar.startOfDay(for: date)
                }
            }
            let days = grouped.sorted { $0.key < $1.key }.prefix(5)
            return days.map { (date, items) in
                // pick first
                let chosen = items.first!
                return ForecastItem(dt: chosen.dt, main: chosen.main, weather: chosen.weather, clouds: chosen.clouds, wind: chosen.wind, visibility: chosen.visibility, pop: chosen.pop, sys: chosen.sys, dtTxt: chosen.dtTxt, snow: chosen.snow, rain: chosen.rain)
            }
        }
}
