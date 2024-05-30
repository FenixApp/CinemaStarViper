// MovieActor.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Информация об актере
struct MovieActor: Identifiable, Codable {
    var id = UUID()
    /// Имя актера
    let name: String
    /// Ссылка на изображение актера
    let imageURL: String
    var image: Data?

    init?(dto: PersonDTO) {
        guard let name = dto.name else { return nil }
        self.name = name
        imageURL = dto.photo ?? ""
    }
}
