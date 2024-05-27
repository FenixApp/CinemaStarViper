// NetworkRequest.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для описания объекта при запросе в сеть
protocol NetworkRequest: AnyObject {
    /// Модель для использования объектов разных типов
    associatedtype ModelType
    /// Декодирование данных
    /// - Parameters:
    /// - data: Данные для декодирования
    /// - Returns:
    /// - Декодированный объект с типом, соответствующим ассоциативному типу - DTO
    func decode(_ data: Data) -> ModelType?
    /// Выполнение запроса в сеть
    func execute(withCompletion completion: @escaping (ModelType?) -> Void)
}

// MARK: - NetworkRequest + load

extension NetworkRequest {
    /// Загрузка данных из сети с завершающимся замыканием (вызывается при получении данных)
    /// - Parameters:
    /// - url: Ссылка, по которой загружаются данные
    func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        var request = URLRequest(url: url)
        request.setValue("0KP9NZQ-KWB4E3K-PXX8XVX-GP8T0PD", forHTTPHeaderField: "X-API-KEY")
        URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
            guard let data = data, let value = self?.decode(data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async { completion(value) }
        }.resume()
    }
}

/// Описание объекта при запросе в сеть
class APIRequest<Resource: APIResource> {
    let resource: Resource

    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        return try? decoder.decode(Resource.ModelType.self, from: data)
    }

    func execute(withCompletion completion: @escaping (Resource.ModelType?) -> Void) {
        if let url = resource.url {
            load(url, withCompletion: completion)
        }
    }
}
