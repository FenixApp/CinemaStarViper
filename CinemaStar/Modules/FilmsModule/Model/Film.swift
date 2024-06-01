// Film.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Модель фильма
struct Film {
    let imageUrl: String?
    let filmName: String?
    let rating: Double?
    let id: Int
    var image: UIImage?

    init(dto: FilmDTO) {
        imageUrl = dto.poster.url
        filmName = dto.name
        rating = dto.rating?.kp
        id = dto.id
    }
}
