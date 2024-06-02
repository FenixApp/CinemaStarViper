// FilmDetailsPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation
import SwiftData

///  Протокол для презентера
protocol FilmDetailsPresenterProtocol: ObservableObject {
    /// Запрос на получение описания фильма с нетворк сервиса
    func prepareFilmDetails(by id: Int, context: ModelContext)
    /// Передача описания фильма с интерактора во вью
    func didFetchFilmDetail(_ film: FilmDetail)
}

/// Презентер экрана с детальным описанием фильма
final class FilmDetailsPresenter: FilmDetailsPresenterProtocol {
    @Published var state: ViewState<FilmDetail> = .loading
    var view: FilmDetailsView?
    var interactor: FilmDetailsInteractorProtocol?
    var router: FilmDetailsRouterProtocol?

    private var context: ModelContext?

    func prepareFilmDetails(by id: Int, context: ModelContext) {
        interactor?.fetchFilmDetails(by: id)
        self.context = context
    }

    func didFetchFilmDetail(_ film: FilmDetail) {
        state = .data(film)
        saveToContext(film: film)
    }

    func saveToContext(film: FilmDetail) {
        guard let imageData = film.image?.jpegData(compressionQuality: 0.8),
              let context = context,
              view?.filmDetail.firstIndex(where: { $0.filmID == film.filmID }) == nil else { return }
        context.insert(SwiftDataFilmDetails(
            filmName: film.filmName,
            filmRating: film.filmRating,
            imageURL: film.imageURL,
            id: film.filmID,
            description: film.description,
            year: film.year,
            country: film.country,
            contentType: film.contentType,
            actors: film.actors,
            language: film.language,
            similarFilms: film.similarFilms,
            image: imageData
        ))
    }
}
