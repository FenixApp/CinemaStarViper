// FilmsDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Список фильмов
struct FilmListDTO: Codable {
    /// Фильмы
    let docs: [FilmDocDTO]
}

/// Фильм
struct FilmDocDTO: Codable {
    /// Номер (идентификатор фильма)
    let id: Int
    /// Название фильма
    let name: String
    /// Изображение фильма
    let poster: PosterDTO
    /// Рейтинг фильма
    let rating: RatingDTO
}

/// Изображение фильма
struct PosterDTO: Codable {
    /// Ссылка на изображение
    let url: URL
}

/// Рейтинг фильма
struct RatingDTO: Codable {
    /// Рейтинг
    let kp: Double
}
