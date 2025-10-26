//
//  NetworkClient.swift
//  WeatherForecast
//
//  Created by Drashti Lakhani on 10/23/25.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case decodingError(Error)
}

final class NetworkClient {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func request<T: Decodable>(_ urlRequest: URLRequest) async throws -> T {
        let (data, response) = try await urlSession.data(for: urlRequest)
        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
            throw NetworkError.invalidResponse
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
