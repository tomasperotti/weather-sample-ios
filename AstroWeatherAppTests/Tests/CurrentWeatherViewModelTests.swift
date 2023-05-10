//
//  CurrentWeatherViewModelTests.swift
//  AstroWeatherAppTests
//
//  Created by Tomás Perotti on 09/05/2023.
//

import XCTest
import Combine
@testable import AstroWeatherApp

final class CurrentWeatherViewModelTests: XCTestCase {

    var viewModel: CurrentWeatherViewModel!
    var mockClient = MockNetworking()
    
    override func setUp() {
        viewModel = CurrentWeatherViewModel(client: mockClient)
    }

    func test_whenDataIsRetrievedSuccessfully() {
        mockClient.shouldSucceed = true
        viewModel.fetchData(from: (lat: 30, long: 30))
        
        guard let data = viewModel.data else { XCTFail("Data from CurrentWeatherViewModel should not be nil") ; return }
        
        XCTAssertEqual(data.description, "cloudy")
        XCTAssertEqual(data.temp, String(10))
        XCTAssertEqual(data.humidity, String(60))
    }
    
    func test_whenDataIsNotRetrievedCorrectly() {
        mockClient.shouldSucceed = false
        mockClient.mockResponse = Just(WeatherDTO(main: .init(temp: 10,
                                                              feelsLike: 10,
                                                              tempMin: 10,
                                                              tempMax: 10,
                                                              pressure: 5,
                                                              humidity: 60),
                                                  wind: .init(speed: 10),
                                                  weather: [.init(id: 0, main: "", description: "cloudy", icon: "noicon")]))
                   .setFailureType(to: Error.self)
                   .eraseToAnyPublisher()
        
        viewModel.fetchData(from: (lat: 30, long: 30))
        
        XCTAssertNil(viewModel.data, "Data should be nil.")
    }
    
    /// Testing where response is being mapped correctly due to presentation definitions, such as rounding to nearestOrEven and convert to a string with no decimals.
    func test_dataIsBeingMappedCorrectly() {
        mockClient.shouldSucceed = true
        mockClient.mockResponse = Just(WeatherDTO(main: .init(temp: 10.25,
                                                              feelsLike: 10.60,
                                                              tempMin: 12.30,
                                                              tempMax: 10.30,
                                                              pressure: 5,
                                                              humidity: 60),
                                                  wind: .init(speed: 10),
                                                  weather: [.init(id: 0, main: "", description: "cloudy", icon: "noicon")]))
                   .setFailureType(to: Error.self)
                   .eraseToAnyPublisher()
        viewModel.fetchData(from: (lat: 30, long: 30))
        
        guard let data = viewModel.data else { XCTFail("Data from CurrentWeatherViewModel should not be nil") ; return }
        
        XCTAssertEqual(data.description, "cloudy")
        XCTAssertEqual(data.temp, "10")
        XCTAssertEqual(data.feelsLike, "11")
    }
}

class MockNetworking: NetworkClientProtocol {
    
    var mockResponse = Just(WeatherDTO(main: .init(temp: 10,
                                                   feelsLike: 10,
                                                   tempMin: 10,
                                                   tempMax: 10,
                                                   pressure: 5,
                                                   humidity: 60),
                                       wind: .init(speed: 10),
                                       weather: [.init(id: 0, main: "", description: "cloudy", icon: "noicon")]))
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    
    var shouldSucceed = false

    var returnedData = 0
    
    func fetchData<T>(_ type: T.Type, from endpoint: String) -> AnyPublisher<T, Error> where T : Decodable {
        if shouldSucceed {
            return mockResponse.map { $0 as! T }.eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "MockErrorDomain", code: 1, userInfo: nil))
                .eraseToAnyPublisher()
        }
    }

}
