// SimilarFilm.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Похожий фильм
struct SimilarFilm: Identifiable, Codable {
    let imageUrl: String?
    let filmName: String?
    let rating: Double?
    let id: Int
    var image: Data?

    init(dto: FilmDTO) {
        imageUrl = dto.poster.url
        filmName = dto.name
        rating = dto.rating?.kp
        id = dto.id
    }
}
