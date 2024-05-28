// FilmDetail.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

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
//    /// Актеры
//    let persons: [PersonDTO]
    /// Язык
    let spokenLanguage: String?
    /// Похожие фильмы
    let similarMovies: [SimilarMoviesDTO]?

//    init(filmDetailDTO: DetailFilmDTO) {
//        poster = filmDetailDTO.poster.url
//        name = filmDetailDTO.name
//        rating = round(filmDetailDTO.rating.kp * 10) / 10.0
//        description = filmDetailDTO.description
//        year = filmDetailDTO.year
//        country = filmDetailDTO.countries.first?.name
//        persons = filmDetailDTO.persons
//        spokenLanguage = filmDetailDTO.spokenLanguages?.first?.name
//        similarMovies = filmDetailDTO.similarMovies
//        if filmDetailDTO.type == "movie" {
//            type = .film
//        } else {
//            type = .serial
//        }
//    }
}

/// Детали фильма
struct MovieDetail {
    let movieName: String
    let movieRating: Double?
    let imageURL: URL?
    let id: Int
    let description: String?
    let year: Int?
    let country: String?
    let contentType: String?
    var actors: [MovieActor] = []
    let language: String?
    var similarMovies: [Movie] = []
    var image: UIImage?

    init(dto: MovieDTO) {
        movieName = dto.name
        movieRating = dto.rating?.kp
        imageURL = URL(string: dto.poster.url)
        id = dto.id
        description = dto.description
        year = dto.year
        country = dto.countries?.first?.name ?? ""
        contentType = {
            if dto.type == "movie" {
                return "Фильм"
            } else {
                return "Сериал"
            }
        }()
        language = dto.spokenLanguages?.first?.name
        dto.persons?.forEach { actor in
            if let actor = MovieActor(dto: actor) {
                actors.append(actor)
            }
        }
        dto.similarMovies?.forEach { similarMovies.append(Movie(dto: $0)) }
    }
}

/// Информация об актере
struct MovieActor {
    /// Имя актера
    let name: String
    /// Ссылка на изображение актера
    let imageURL: String

    init?(dto: PersonDTO) {
        guard let name = dto.name else { return nil }
        self.name = name
        imageURL = dto.photo ?? ""
    }
}
