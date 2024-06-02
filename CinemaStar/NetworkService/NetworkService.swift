// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import SwiftUI

/// Протокол для нетворк сервиса
protocol NetworkServiceProtocol {
    /// Запрос на получение списка фильмов
    func fetchFilms() -> AnyPublisher<FilmsDTO, Error>
    /// Запрос на получения фильма
    func fetchFilm(by id: Int) -> AnyPublisher<FilmDTO, Error>
    /// Запрос на получение изображения
    func fetchImage(from url: URL) -> AnyPublisher<UIImage?, Error>
}

/// Нетворк сервис
class NetworkService: NetworkServiceProtocol {
    enum Constants {
        static let baseUrl = "https://api.kinopoisk.dev/v1.4/movie/"
        static let filmsUrl = "https://api.kinopoisk.dev/v1.4/movie/search?query=история"
        static let apiKey = "0KP9NZQ-KWB4E3K-PXX8XVX-GP8T0PD"
        static let headerField = "X-API-KEY"
    }

    func fetchFilms() -> AnyPublisher<FilmsDTO, Error> {
        guard let url = URL(string: Constants.filmsUrl) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.setValue(Constants.apiKey, forHTTPHeaderField: Constants.headerField)

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
        request.setValue(Constants.apiKey, forHTTPHeaderField: Constants.headerField)

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
