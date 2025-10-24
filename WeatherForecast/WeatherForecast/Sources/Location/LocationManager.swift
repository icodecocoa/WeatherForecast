//
//  LocationManager.swift
//  WeatherForecast
//
//  Created by Drashti Lakhani on 10/24/25.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var continuation: CheckedContinuation<CLLocationCoordinate2D, Error>?
    private var hasResumed = false

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestLocation() async throws -> CLLocationCoordinate2D {
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            self.hasResumed = false

            let status = locationManager.authorizationStatus
            switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                // We'll request the location after we get an authorization callback
            case .restricted, .denied:
                self.resumeOnce(throwing: CLError(.denied))
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.requestLocation()
            @unknown default:
                self.resumeOnce(throwing: CLError(.locationUnknown))
            }
        }
    }

    private func resumeOnce(returning coordinate: CLLocationCoordinate2D) {
        guard !hasResumed else { return }
        hasResumed = true
        continuation?.resume(returning: coordinate)
        continuation = nil
    }

    private func resumeOnce(throwing error: Error) {
        guard !hasResumed else { return }
        hasResumed = true
        continuation?.resume(throwing: error)
        continuation = nil
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.first else { return }
        resumeOnce(returning: loc.coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        resumeOnce(throwing: error)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .restricted, .denied:
            resumeOnce(throwing: CLError(.denied))
        default:
            break
        }
    }
}
