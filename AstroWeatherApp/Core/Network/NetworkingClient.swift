//
//  NetworkingClient.swift
//  AstroWeatherApp
//
//  Created by Tomás Perotti on 08/05/2023.
//

import Combine
import Foundation

enum NetworkError: Error {
    case invalidURL
    case network(Error)
    case decoding(Error)
}

protocol NetworkClientProtocol {
    /// Method used for fetching data from an endpoint and decoded to a type conforming Decodable.
    /// - Parameters:
    ///   - type: type client wants to decode conforming Decodable.
    ///   - endpoint: URL in string where clients wants to perform the request.
    /// - Returns: Publisher with the decoded value.
    func fetchData<T: Decodable>(_ type: T.Type, from endpoint: String) -> AnyPublisher<T, Error>
}

struct NetworkClient: NetworkClientProtocol {
    
    func fetchData<T: Decodable>(_ type: T.Type, from endpoint: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: endpoint) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .mapError { error in NetworkError.network(error) }
            .flatMap { data, response -> AnyPublisher<T, Error> in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 // use your preferred date decoding strategy here
                return Just(data)
                    .decode(type: T.self, decoder: decoder)
                    .mapError { error in NetworkError.decoding(error) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
