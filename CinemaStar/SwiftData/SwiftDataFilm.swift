// SwiftDataFilm.swift
// Copyright © RoadMap. All rights reserved.

import SwiftData
import SwiftUI

@Model
final class SwiftDataFilm {
    let imageUrl: String
    let filmName: String
    let rating: Double
    let filmID: Int
    var image: Data?
    var id = UUID()

    init(imageUrl: String, filmName: String, rating: Double, id: Int, image: Data?) {
        self.imageUrl = imageUrl
        self.filmName = filmName
        self.rating = rating
        filmID = id
        self.image = image
    }
}
