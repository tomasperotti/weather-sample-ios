//
//  CurrentWeatherViewModel.swift
//  AstroWeatherApp
//
//  Created by Tomás Perotti on 08/05/2023.
//

import SwiftUI
import Combine
import Foundation

class CurrentWeatherViewModel: ObservableObject {
    let apiKey = "6c5543b8a90adb106a9bff58d7a436b1"
    @Published var data: WeatherModel?
    @Published var isLoading = false
    private var cancellable: AnyCancellable?
    private let client: NetworkClientProtocol
    private let mapper: WeatherDTOMapper
    
    init(client: NetworkClientProtocol = NetworkClient(),
         mapper: WeatherDTOMapper = WeatherDTOMapper()) {
        self.client = client
        self.mapper = mapper
    }
    
    /// Fetch weather's data from given coordinates
    /// - Parameter coordinates: coordinates for the location clients want to retrieve the information.
    func fetchData(from coordinates: (lat: Double, long: Double)) {
        isLoading = true
        let url = "https://api.openweathermap.org/data/2.5/weather?units=metric&lat=\(coordinates.lat)&lon=\(coordinates.long)&exclude=hourly,daily&appid=\(apiKey)"

        cancellable = client.fetchData(WeatherDTO.self, from: url)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] response in
                    self?.data = self?.mapper.map(from: response)
                    self?.isLoading = false
            })
    }
}
