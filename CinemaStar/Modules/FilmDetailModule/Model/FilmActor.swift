// FilmActor.swift

import Foundation

/// Информация об актере
struct FilmActor: Identifiable, Codable {
    /// Идентификатор
    var id = UUID()
    /// Имя
    let name: String
    /// Ссылка на изображение с актером
    let imageURL: String
    /// Изображение
    var image: Data?

    init?(dto: PersonDTO) {
        guard let name = dto.name else { return nil }
        self.name = name
        imageURL = dto.photo ?? ""
    }
}
