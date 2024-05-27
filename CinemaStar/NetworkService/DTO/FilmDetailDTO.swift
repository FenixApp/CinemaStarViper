// FilmDetailDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Детальное описание фильма
struct DetailFilmDTO: Codable {
    /// Название
    let name: String
    /// Изображение
    let poster: PosterDTO
    /// Рейтинг
    let rating: RatingDTO
    /// Описание
    let description: String
    /// Год выхода
    let year: Int
    /// Страна производства
    let countries: [CountriesDTO]
    /// Фильм или сериал
    let type: String
    /// Актеры
    let persons: [PersonDTO]
    /// Язык
    let spokenLanguages: [SpokenLanguageDTO]?
    /// Похожие фильмы
    let similarMovies: [SimilarMoviesDTO]?
}

/// Старана
struct CountriesDTO: Codable {
    /// Название
    let name: String
}

/// Актер
struct PersonDTO: Codable {
    /// Фото
    let photo: URL
    /// Имя
    let name: String?
}

/// Язык
struct SpokenLanguageDTO: Codable {
    /// Название
    let name: String
}

/// Похожие фильмы
struct SimilarMoviesDTO: Codable {
    /// Изображение
    let poster: PosterDTO
    /// Название
    let name: String
}
