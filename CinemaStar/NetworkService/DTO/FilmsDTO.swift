// FilmsDTO.swift

import Foundation

/// Массив с фильмами
struct FilmsDTO: Codable {
    let docs: [FilmDTO]
}

/// Фильм
struct FilmDTO: Codable {
    /// Наименование фильма
    let name: String
    /// Идентификатор фильма
    let id: Int
    /// ДТО-модель с ссылкой на картинку постера
    let poster: PosterDTO
    /// ДТО-модель с рейтингом фильма
    let rating: RatingDTO?
    /// Описание фильма
    let description: String?
    /// Год выпуска
    let year: Int?
    /// ДТО-модель со странами
    let countries: [CountriesDTO]?
    /// Фильм/сериал
    let type: String?
    /// ДТО-модель с актерами
    let persons: [PersonDTO]?
    /// ДТО-модель с международными языками
    let spokenLanguages: [SpokenLanguagesDTO]?
    /// ДТО-модель рекомендуемых фильмов
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
