// FilmsDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Массив фильмов
struct FilmsDTO: Codable {
    let docs: [FilmDTO]
}

/// Фильм
struct FilmDTO: Codable {
    /// Имя фильма
    let name: String
    /// ID фильма
    let id: Int
    /// ДТО-модель с ссылкой на картинку постера
    let poster: PosterDTO
    /// ДТО-модель с рейтингом фильма
    let rating: RatingDTO?
    /// Описание фильма
    let description: String?
    /// Год выпуска
    let year: Int?
    /// Страны
    let countries: [CountriesDTO]?
    /// Тип контента
    let type: String?
    /// Актеры
    let persons: [PersonDTO]?
    /// Языки
    let spokenLanguages: [SpokenLanguagesDTO]?
    /// Похожие фильмы
    let similarFilms: [FilmDTO]?
}

/// Картинка фильма
struct PosterDTO: Codable {
    let url: String
}

/// Рейтинг фильма
struct RatingDTO: Codable {
    let kp: Double
}

/// Страна производства фильма
struct CountriesDTO: Codable {
    /// Название страны
    let name: String
}

/// Актеры
struct PersonDTO: Codable {
    /// Имя актера
    let name: String?
    /// Ссылка на изображение актера
    let photo: String?
}

/// Язык фильма
struct SpokenLanguagesDTO: Codable {
    /// Название языка
    let name: String
}
