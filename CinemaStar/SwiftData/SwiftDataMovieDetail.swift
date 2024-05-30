// SwiftDataMovieDetail.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftData

@Model
final class SwiftDataMovieDetail: Identifiable {
    let movieName: String
    let movieRating: Double?
    let imageURL: String?
    let movieID: Int
    let movieDescription: String?
    let year: Int?
    let country: String?
    let contentType: String?
    var actors: [MovieActor] = []
    let language: String?
    var similarMovies: [SimilarMovie] = []
    var image: Data?
    var id = UUID()

    init(
        movieName: String,
        movieRating: Double?,
        imageURL: String?,
        id: Int,
        description: String?,
        year: Int?,
        country: String?,
        contentType: String?,
        actors: [MovieActor],
        language: String?,
        similarMovies: [SimilarMovie],
        image: Data? = nil
    ) {
        self.movieName = movieName
        self.movieRating = movieRating
        self.imageURL = imageURL
        movieID = id
        movieDescription = description
        self.year = year
        self.country = country
        self.contentType = contentType
        self.actors = actors
        self.language = language
        self.similarMovies = similarMovies
        self.image = image
    }
}
