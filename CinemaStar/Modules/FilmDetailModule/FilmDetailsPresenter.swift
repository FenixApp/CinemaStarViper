// FilmDetailsPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation
import SwiftData

///  Протокол для взаимодействия с презентером
protocol FilmDetailsPresenterProtocol: ObservableObject {
    func prepareFilmDetails(by id: Int, context: ModelContext)
    func didFetchFilmDetail(_ movie: FilmDetail)
}

/// Презентер для  экрана с детальным фильмом
class FilmDetailsPresenter: FilmDetailsPresenterProtocol {
    @Published var state: ViewState<FilmDetail> = .loading
//    private var movieDetail = PassthroughSubject<SwiftDataMovieDetail, Never>()
    private var context: ModelContext?

    var view: FilmDetailsView?
    var interactor: FilmDetailsInteractorProtocol?
    var router: FilmDetailsRouterProtocol?

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
