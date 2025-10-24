//
//  WeatherDayRowView.swift
//  WeatherForecast
//
//  Created by Drashti Lakhani on 10/24/25.
//

import SwiftUI

struct WeatherDayRowView: View {
    let day: ForecastItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Day Title
            Text(day.dtTxt.dayOfWeek ?? "")
                .font(.system(size: 18, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Weather Icon & Temperature
            HStack(alignment: .center, spacing: 8) {
                Image(assetName(for: day.weather.first?.icon ?? ""))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60, alignment: .leading)
                
                Text("\(Int(day.main.temp.rounded())) °C")
                    .font(.system(size: 36, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    // Map API icon code to asset name
    private func assetName(for iconCode: String) -> String {
        switch iconCode {
        case "01d", "01n": return "Property 1=01.sun-light"
        case "02d", "02n": return "Property 1=05.partial-cloudy-light"
        case "03d", "03n": return "Property 1=11.mostly-cloudy-light"
        case "04d", "04n": return "Property 1=07.mostly-cloud-light"
        case "09d", "09n": return "Property 1=20.rain-light"
        case "10d", "10n": return "Property 1=06.rainyday-light"
        case "11d", "11n": return "Property 1=13.thunderstorm-light"
        case "13d", "13n": return "Property 1=22.snow-light"
        case "50d", "50n": return "Property 1=24.drop-light"
        default: return "Property 1=01.sun-light" // fallback icon
        }
    }
}
