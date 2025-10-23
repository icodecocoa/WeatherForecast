//
//  OpenWeatherAPI.swift
//  WeatherForecast
//
//  Created by Drashti Lakhani on 10/23/25.
//

import Foundation

struct OpenWeatherAPI {
    private let apiKey: String
    private let client: NetworkClient
    
    init(apiKey: String, client: NetworkClient) {
        self.apiKey = apiKey
        self.client = client
    }
    
    func fetchFiveDayForecast(forLatitude latitude: Double, andLongitude longitude: Double) async throws -> WeatherForecastResponse {
        var comps = URLComponents(string: "https://api.openweathermap.org/data/2.5/forecast")!
        comps.queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        guard let url = comps.url else {
            throw URLError(.badURL)
        }
        let req = URLRequest(url: url)
        return try await client.request(req) as WeatherForecastResponse
    }
}
