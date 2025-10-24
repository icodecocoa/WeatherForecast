//
//  WeatherRepositoryTests.swift
//  WeatherForecast
//
//  Created by Drashti Lakhani on 10/24/25.
//

import XCTest
@testable import WeatherForecast

@MainActor
final class WeatherRepositoryTests: XCTestCase {
    
    private var repository: WeatherRepositoryImpl!
    private var mockAPI: MockWeatherRepository!
    
    override func setUp() {
        super.setUp()
        mockAPI = MockWeatherRepository()
        repository = WeatherRepositoryImpl(api: mockAPI)
    }
    
    override func tearDown() {
        repository = nil
        mockAPI = nil
        super.tearDown()
    }
    
    func test_fetchFiveDayForecast_success() async throws {
        // Arrange
        mockAPI.shouldSucceed = true
        mockAPI.mockForecast = WeatherForecastResponse.mock(count: 40)
        mockAPI.customError = nil
        
        // Act
        let result = try await repository.fetchFiveDayForecast(lat: 25.2048, lon: 55.2708)
        
        // Assert
        XCTAssertEqual(result.count, 5, "Repository should return exactly 5 forecast days.")
        XCTAssertTrue(result.allSatisfy { $0.main.temp > 0 }, "All forecast temps should be positive.")
    }
    
    func test_fetchFiveDayForecast_failure() async {
        // Arrange
        mockAPI.shouldSucceed = false
        mockAPI.mockForecast = nil
        mockAPI.customError = .serverError
        
        // Act
        do {
            _ = try await repository.fetchFiveDayForecast(lat: 0.0, lon: 0.0)
            XCTFail("Expected repository to throw an error, but succeeded.")
        } catch {
            // Assert
            guard let apiError = error as? RepositoryError else {
                return XCTFail("Expected RepositoryError, got \(error)")
            }
            XCTAssertEqual(apiError, .serverError)
        }
    }
}
