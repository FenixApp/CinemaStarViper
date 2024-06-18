// FilmDetail.swift

import SwiftUI

/// Детальное описание фильма
struct FilmDetail: Identifiable {
    /// Название фильма
    let filmName: String
    /// Рейтинг
    let filmRating: Double?
    /// Ссылка на изображение
    let imageURL: String?
    /// Идентификатор
    let filmID: Int
    /// Описание
    let description: String?
    /// Год выхода
    let year: Int?
    /// Страна производства
    let country: String?
    /// Фильм/сериал
    let contentType: String?
    /// Актеры
    var actors: [FilmActor] = []
    /// Язык фильма
    let language: String?
    /// Рекомендуемые фильмы
    var similarFilms: [SimilarFilm] = []
    /// Картинка
    var image: UIImage?
    /// Идентификатор
    var id = UUID()

    init(dto: FilmDTO) {
        filmName = dto.name
        filmRating = dto.rating?.kp
        imageURL = dto.poster.url
        filmID = dto.id
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
            if let actor = FilmActor(dto: actor) {
                actors.append(actor)
            }
        }
        dto.similarFilms?.forEach { similarFilms.append(SimilarFilm(dto: $0)) }
    }

    init() {
        filmName = ""
        filmRating = nil
        imageURL = nil
        filmID = 1
        description = nil
        year = nil
        country = nil
        contentType = nil
        language = nil
    }
}
