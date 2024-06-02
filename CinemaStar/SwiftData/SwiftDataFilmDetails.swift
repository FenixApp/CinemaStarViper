// SwiftDataFilmDetails.swift
// Copyright © RoadMap. All rights reserved.

import SwiftData
import SwiftUI

/// Модель детального описания фильма
@Model
final class SwiftDataFilmDetails: Identifiable {
    /// Наименование фильма
    let filmName: String
    /// Рейтинг фильма
    let filmRating: Double?
    /// Путь к картинке
    let imageURL: String?
    /// Идентификатор фильма
    let filmID: Int
    /// Описание фильма
    let filmDescription: String?
    /// Год выхода
    let year: Int?
    /// Страна выпуска
    let country: String?
    /// сериал/фильм
    let contentType: String?
    /// Актерский состав
    var actors: [FilmActor] = []
    /// Язык озвучки
    let language: String?
    /// Рекомендуемые фильмы
    var similarFilms: [SimilarFilm] = []
    /// Картинка
    var image: Data?
    /// Идентификатор
    var id = UUID()

    init(
        filmName: String,
        filmRating: Double?,
        imageURL: String?,
        id: Int,
        description: String?,
        year: Int?,
        country: String?,
        contentType: String?,
        actors: [FilmActor],
        language: String?,
        similarFilms: [SimilarFilm],
        image: Data? = nil
    ) {
        self.filmName = filmName
        self.filmRating = filmRating
        self.imageURL = imageURL
        filmID = id
        filmDescription = description
        self.year = year
        self.country = country
        self.contentType = contentType
        self.actors = actors
        self.language = language
        self.similarFilms = similarFilms
        self.image = image
    }
}
