// FilmDetail.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Подробная информация о фильме
struct FilmDetail {
    enum MovieType: String {
        case film = "Фильм"
        case serial = "Сериал"
    }

    /// Изображение фильма
    let poster: URL
    /// Название
    let name: String
    /// Рейтинг
    let rating: Double
    /// Описание
    let description: String
    /// Год выхода
    let year: Int?
    /// Страна производства
    let country: String?
    /// Фильм или сериал
    let type: MovieType
    /// Актеры
    let persons: [PersonDTO]
    /// Язык
    let spokenLanguage: String?
    /// Похожие фильмы
    let similarMovies: [SimilarMoviesDTO]?

    init(filmDetailDTO: DetailFilmDTO) {
        poster = filmDetailDTO.poster.url
        name = filmDetailDTO.name
        rating = round(filmDetailDTO.rating.kp * 10) / 10.0
        description = filmDetailDTO.description
        year = filmDetailDTO.year
        country = filmDetailDTO.countries.first?.name
        persons = filmDetailDTO.persons
        spokenLanguage = filmDetailDTO.spokenLanguages?.first?.name
        similarMovies = filmDetailDTO.similarMovies
        if filmDetailDTO.type == "movie" {
            type = .film
        } else {
            type = .serial
        }
    }
}
