// Film.swift

import SwiftUI

/// Модель фильма
struct Film {
    /// Ссылка на изображение фильма
    let imageUrl: String?
    /// Наименование фильма
    let filmName: String?
    /// Рейтинг фильма
    let rating: Double?
    /// Идентификатор
    let id: Int
    /// картинка
    var image: UIImage?

    init(dto: FilmDTO) {
        imageUrl = dto.poster.url
        filmName = dto.name
        rating = dto.rating?.kp
        id = dto.id
    }
}
