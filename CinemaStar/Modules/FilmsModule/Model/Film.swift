// Film.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Данные фильма
struct Film {
    /// Ссылка на изображение
    let posterURL: URL
    /// Название фильма
    let name: String
    /// Рейтинг фильма
    let rating: Double
    /// Номер (идентификатор фильма)
    let id: Int

    init(filmDTO: FilmDocDTO) {
        posterURL = filmDTO.poster.url
        name = filmDTO.name
        rating = round(filmDTO.rating.kp * 10) / 10.0
        id = filmDTO.id
    }
}
