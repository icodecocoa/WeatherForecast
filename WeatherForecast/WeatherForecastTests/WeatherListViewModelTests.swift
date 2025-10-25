//
//  WeatherListViewModelTests.swift
//  WeatherForecast
//
//  Created by Drashti Lakhani on 10/24/25.
//

import XCTest
@testable import WeatherForecast

@MainActor
final class WeatherListViewModelTests: XCTestCase {
    private var viewModel: WeatherListViewModel!
    private var mockRepository: MockWeatherRepository!
    private var mockLocationManager: MockLocationManager!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockWeatherRepository()
        mockLocationManager = MockLocationManager()
        viewModel = WeatherListViewModel(repo: mockRepository, locationManager: mockLocationManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockLocationManager = nil
        super.tearDown()
    }
    
    func test_initialState_isIdle() {
        if case .idle = viewModel.state {
            XCTAssert(true)
        } else {
            XCTFail("Initial state was not .idle")
        }
    }
    
    func test_loadWeather_successChangesStateToLoaded() async {
        // Arrange
        mockRepository.shouldSucceed = true
        mockRepository.mockForecast = WeatherForecastResponse.mock(count: 5).list
        
        // Act
        await viewModel.fetchWeather()
        
        // Assert
        if case .loaded(let items) = viewModel.state {
            XCTAssertEqual(items.count, 5, "Loaded should contain 5 forecast items.")
        } else {
            XCTFail("Expected .loaded state, got \(viewModel.state)")
        }
    }
    
    func test_loadWeather_failureChangesStateToFailed() async {
        // Arrange
        mockRepository.shouldSucceed = false
        mockRepository.customError = RepositoryError.serverError
        
        // Act
        await viewModel.fetchWeather()
        
        // Assert
        if case .failed(let message) = viewModel.state {
            XCTAssertTrue(message.contains("RepositoryError"), "Error message should mention repository error.")
        } else {
            XCTFail("Expected .failed state, got \(viewModel.state)")
        }
    }
}
