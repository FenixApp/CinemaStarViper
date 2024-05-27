// APIResource.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол с описанием объекта ресурса (по которому грузятся данные из сети)
protocol APIResource {
    /// Тип данных для декодирования
    associatedtype ModelType: Decodable
    /// Путь для запроса
    var methodPath: String { get }
    /// Параметры запроса
    var queryItems: [URLQueryItem]? { get }
}

// MARK: - Extension APIResource + URL

extension APIResource {
    /// Путь, по которому загружаются данные из сети
    var url: URL? {
        /// URL-адрес API
        var components = URLComponents(string: "https://api.kinopoisk.dev/v1.4/movie") ?? URLComponents()
        components.path += methodPath
        if let queryItems {
            components.queryItems = queryItems
        }
        return components.url
    }
}
