// SimilarFilm.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Рекомендуемый фильм
struct SimilarFilm: Identifiable, Codable {
    /// Ссылка на картинку
    let imageUrl: String?
    /// Название
    let filmName: String?
    /// Рейтинг
    let rating: Double?
    /// Идентификатор
    let id: Int
    /// Изображение
    var image: Data?

    init(dto: FilmDTO) {
        imageUrl = dto.poster.url
        filmName = dto.name
        rating = dto.rating?.kp
        id = dto.id
    }
}
