// SimilarMovie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Похожий фильм
struct SimilarMovie: Identifiable, Codable {
    let imageUrl: String?
    let movieName: String?
    let rating: Double?
    let id: Int
    var image: Data?

    init(dto: MovieDTO) {
        imageUrl = dto.poster.url
        movieName = dto.name
        rating = dto.rating?.kp
        id = dto.id
    }
}
