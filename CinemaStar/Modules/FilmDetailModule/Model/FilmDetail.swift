// FilmDetail.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Детали фильма
struct MovieDetail: Identifiable {
    let movieName: String
    let movieRating: Double?
    let imageURL: String?
    let movieID: Int
    let description: String?
    let year: Int?
    let country: String?
    let contentType: String?
    var actors: [MovieActor] = []
    let language: String?
    var similarMovies: [SimilarMovie] = []
    var image: UIImage?
    var id = UUID()

    init(dto: MovieDTO) {
        movieName = dto.name
        movieRating = dto.rating?.kp
        imageURL = dto.poster.url
        movieID = dto.id
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
        dto.similarMovies?.forEach { similarMovies.append(SimilarMovie(dto: $0)) }
    }

    init() {
        movieName = ""
        movieRating = nil
        imageURL = nil
        movieID = 1
        description = nil
        year = nil
        country = nil
        contentType = nil
        language = nil
    }
}
