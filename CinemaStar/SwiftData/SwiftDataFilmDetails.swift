// SwiftDataFilmDetails.swift
// Copyright © RoadMap. All rights reserved.

import SwiftData
import SwiftUI

@Model
final class SwiftDataFilmDetails: Identifiable {
    let filmName: String
    let filmRating: Double?
    let imageURL: String?
    let filmID: Int
    let filmDescription: String?
    let year: Int?
    let country: String?
    let contentType: String?
    var actors: [FilmActor] = []
    let language: String?
    var similarFilms: [SimilarFilm] = []
    var image: Data?
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
