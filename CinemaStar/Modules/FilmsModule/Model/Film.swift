// Film.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

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

//    init(filmDTO: FilmDocDTO) {
//        posterURL = filmDTO.poster.url
//        name = filmDTO.name
//        rating = round(filmDTO.rating.kp * 10) / 10.0
//        id = filmDTO.id
//    }
}

/// Модель фильма
struct Movie {
    let imageUrl: URL?
    let movieName: String?
    let rating: Double?
    let id: Int
    var image: UIImage?

    init(dto: MovieDTO) {
        imageUrl = URL(string: dto.poster.url)
        movieName = dto.name
        rating = dto.rating?.kp
        id = dto.id
    }
}
