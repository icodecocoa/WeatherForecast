//
//  LocationManagerError.swift
//  WeatherForecast
//
//  Created by Drashti Lakhani on 10/24/25.
//

// Mocks.swift

import Foundation
import CoreLocation
import Combine

// --- Mock LocationManager ---

enum LocationManagerError: Error {
    case locationDenied
    case genericError
}

final class MockLocationManager: LocationManager {
    var shouldSucceed: Bool = true
    var mockCoordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437)
    
    override func requestLocation() async throws -> CLLocationCoordinate2D {
        if shouldSucceed {
            return mockCoordinates
        } else {
            throw LocationManagerError.locationDenied
        }
    }
}

// --- Mock WeatherRepository ---

enum RepositoryError: Error {
    case networkError
    case parsingError
}

final class MockWeatherRepository: WeatherRepository {
    var shouldSucceed: Bool = true
    var mockForecast: [ForecastItem] = [
        // Sample minimal ForecastItem for testing
        ForecastItem(dt: 1678886400, main: .init(temp: 280.0, feelsLike: 278.0, tempMin: 279.0, tempMax: 281.0, pressure: 1012, seaLevel: 1012, groundLevel: 1010, humidity: 80, tempKf: 0.0), weather: [.init(id: 800, main: MainEnum.clear, description: Description.clear, icon: "01d")], clouds: .init(all: 0), wind: .init(speed: 3.0, deg: 200, gust: 4.57), visibility: 10000, pop: 0.0, sys: .init(partOfTheDay: .day), dtTxt: "2023-03-15 12:00:00", snow: nil, rain: nil)
    ]
    var customError: Error = RepositoryError.networkError
    
    func fetchFiveDayForecast(lat: Double, lon: Double) async throws -> [ForecastItem] {
        if shouldSucceed {
            return mockForecast
        } else {
            throw customError
        }
    }
}

// --- Helper for creating a simple WeatherForecastResponse response object for Repository tests ---

extension WeatherForecastResponse {
    static func mock(count: Int) -> WeatherForecastResponse {
        let list: [ForecastItem] = (0..<count).map { i in
            let date = Date().addingTimeInterval(TimeInterval(i * 3600)) // 1 hour difference
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dtTxt = dateFormatter.string(from: date)
            
            return ForecastItem(
                dt: Int(date.timeIntervalSince1970),
                main: MainClass(temp: 12.5,
                                feelsLike: 11.16,
                                tempMin: 12.25,
                                tempMax: 12.5,
                                pressure: 1027,
                                seaLevel: 1027,
                                groundLevel: 1025,
                                humidity: 71,
                                tempKf: 0.25),
                weather: [Weather(id: 804,
                                  main: MainEnum.clouds,
                                  description: Description.overcastClouds,
                                  icon: "04n")],
                clouds: Clouds(all: 91),
                wind: Wind(speed: 3.0, deg: 200, gust: 5.47),
                visibility: 10000,
                pop: 0.0,
                sys: Sys(partOfTheDay: PartOfTheDay(rawValue: "d")!),
                dtTxt: dtTxt,
                snow: nil,
                rain: nil)
        }
        
        return WeatherForecastResponse(
            list: list,
            cod: "200",
            message: 0,
            cnt: 40,
            city: City(
                id: 5368361,
                name: "Los Angeles",
                coord: Coordinate(lat: 34.0522, lon: -118.2437),
                country: "US",
                population: 4000000,
                timezone: -25200,
                sunrise: 1708590000,
                sunset: 1708632000
            )
        )
    }
}

