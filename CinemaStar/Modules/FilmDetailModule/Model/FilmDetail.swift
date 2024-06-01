// FilmDetail.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Детали фильма
struct FilmDetail: Identifiable {
    let filmName: String
    let filmRating: Double?
    let imageURL: String?
    let filmID: Int
    let description: String?
    let year: Int?
    let country: String?
    let contentType: String?
    var actors: [FilmActor] = []
    let language: String?
    var similarFilms: [SimilarFilm] = []
    var image: UIImage?
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
