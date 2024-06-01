// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import SwiftUI

/// Протокол для взаимодействия с нетворк сервисом
protocol NetworkServiceProtocol {
    func fetchFilms() -> AnyPublisher<FilmsDTO, Error>
    func fetchImage(from url: URL) -> AnyPublisher<UIImage?, Error>
    func fetchFilm(by id: Int) -> AnyPublisher<FilmDTO, Error>
}

/// Нетворк сервис
class NetworkService: NetworkServiceProtocol {
    enum Constants {
        static let baseUrl = "https://api.kinopoisk.dev/v1.4/movie/"
        static let filmsUrl = "https://api.kinopoisk.dev/v1.4/movie/search?query=история"
    }

    func fetchFilms() -> AnyPublisher<FilmsDTO, Error> {
        guard let url = URL(string: Constants.filmsUrl) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.setValue("0KP9NZQ-KWB4E3K-PXX8XVX-GP8T0PD", forHTTPHeaderField: "X-API-KEY")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: FilmsDTO.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchFilm(by id: Int) -> AnyPublisher<FilmDTO, Error> {
        guard let url = URL(string: "\(Constants.baseUrl)" + "\(id)") else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.setValue("0KP9NZQ-KWB4E3K-PXX8XVX-GP8T0PD", forHTTPHeaderField: "X-API-KEY")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: FilmDTO.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchImage(from url: URL) -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
