//
//  String+DayOfWeek.swift
//  WeatherForecast
//
//  Created by Drashti Lakhani on 10/24/25.
//

import Foundation

extension String {
    /// Converts a date string "yyyy-MM-dd HH:mm:ss" to day of week "Monday", "Tuesday", etc.
    var dayOfWeek: String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = inputFormatter.date(from: self) else { return nil }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEEE"
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return outputFormatter.string(from: date)
    }
}
