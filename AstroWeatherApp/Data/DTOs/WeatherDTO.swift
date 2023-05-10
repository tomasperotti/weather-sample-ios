//
//  Weather.swift
//  AstroWeatherApp
//
//  Created by Tomás Perotti on 04/05/2023.
//

import Foundation

struct WeatherDTO: Codable {
    let main: WeatherMainInformationDTO
    let wind: WindDTO
    let weather: [WeatherElementDTO]
}

struct WeatherMainInformationDTO: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

struct WindDTO: Codable {
    let speed: Double
}

struct WeatherElementDTO: Codable {
    let id: Int
    let main, description, icon: String
}
