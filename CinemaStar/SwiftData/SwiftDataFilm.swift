// SwiftDataFilm.swift

import SwiftData
import SwiftUI

/// Модель фильма
@Model
final class SwiftDataFilm {
    /// Путь к картинке
    let imageUrl: String
    /// Наименование фильма
    let filmName: String
    /// Рейтинг
    let rating: Double
    /// Идентификатор фильма
    let filmID: Int
    /// Картинка
    var image: Data?
    /// Идентификатор
    var id = UUID()

    init(imageUrl: String, filmName: String, rating: Double, id: Int, image: Data?) {
        self.imageUrl = imageUrl
        self.filmName = filmName
        self.rating = rating
        filmID = id
        self.image = image
    }
}
