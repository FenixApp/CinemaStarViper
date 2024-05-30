// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import UIKit

/// Протокол для взаимодействия с нетворк сервисом
protocol NetworkServiceProtocol {
    func fetchMovies() -> AnyPublisher<MoviesDTO, Error>
    func fetchImage(from url: URL) -> AnyPublisher<UIImage?, Error>
    func fetchMovie(by id: Int) -> AnyPublisher<MovieDTO, Error>
}

/// Нетворк сервис
class NetworkService: NetworkServiceProtocol {
    enum Constants {
        static let baseUrl = "https://api.kinopoisk.dev/v1.4/movie/"
        static let moviesUrl = "https://api.kinopoisk.dev/v1.4/movie/search?query=история"
    }

    func fetchMovies() -> AnyPublisher<MoviesDTO, Error> {
        guard let url = URL(string: Constants.moviesUrl) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.setValue("0KP9NZQ-KWB4E3K-PXX8XVX-GP8T0PD", forHTTPHeaderField: "X-API-KEY")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: MoviesDTO.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchMovie(by id: Int) -> AnyPublisher<MovieDTO, Error> {
        guard let url = URL(string: "\(Constants.baseUrl)" + "\(id)") else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.setValue("0KP9NZQ-KWB4E3K-PXX8XVX-GP8T0PD", forHTTPHeaderField: "X-API-KEY")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: MovieDTO.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchImage(from url: URL) -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
