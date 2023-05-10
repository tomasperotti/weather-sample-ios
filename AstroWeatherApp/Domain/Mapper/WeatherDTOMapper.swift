//
//  WeatherDTOMapper.swift
//  AstroWeatherApp
//
//  Created by Tomás Perotti on 09/05/2023.
//

import Foundation

struct WeatherDTOMapper {
    /// Maps WeatherModel from WeatherDTO in order to ease the use of the data in the presentation layer.
    /// - Parameter dto: dto
    /// - Returns: model
    func map(from dto: WeatherDTO) -> WeatherModel {
        let main = dto.main
        let currentTemp = Int((main.temp).rounded(.toNearestOrEven))
        let tempMin = Int((main.tempMin).rounded(.toNearestOrEven))
        let tempMax = Int((main.tempMax).rounded(.toNearestOrEven))

        let feelsLike = Int((main.feelsLike).rounded(.toNearestOrEven))
        let humidity = main.humidity
        let windSpeed = Int((dto.wind.speed.rounded(.toNearestOrEven)))
        let weather = dto.weather
        let icon = weather[0].icon
        let description = weather[0].description
        
        let model = WeatherModel(temp: String(currentTemp),
                                 feelsLike: String(feelsLike),
                                 tempMin: String(tempMin),
                                 tempMax: String(tempMax),
                                 humidity: String(humidity),
                                 description: description,
                                 icon: icon,
                                 windSpeed: String(windSpeed))
        
        return model
    }
}
