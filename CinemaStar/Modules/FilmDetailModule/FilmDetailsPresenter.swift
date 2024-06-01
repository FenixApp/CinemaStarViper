// FilmDetailsPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation
import SwiftData

///  Протокол для взаимодействия с презентером
protocol FilmDetailsPresenterProtocol: ObservableObject {
    func prepareMovieDetails(by id: Int, context: ModelContext)
    func didFetchMovieDetail(_ movie: FilmDetail)
}

/// Презентер для  экрана с детальным фильмом
class FilmDetailsPresenter: FilmDetailsPresenterProtocol {
    @Published var state: ViewState<FilmDetail> = .loading
//    private var movieDetail = PassthroughSubject<SwiftDataMovieDetail, Never>()
    private var context: ModelContext?

    var view: FilmDetailsView?
    var interactor: FilmDetailsInteractorProtocol?
    var router: FilmDetailsRouterProtocol?

    func prepareMovieDetails(by id: Int, context: ModelContext) {
        interactor?.fetchMovieDetails(by: id)
        self.context = context
    }

    func didFetchMovieDetail(_ movie: FilmDetail) {
        state = .data(movie)
        saveToContext(film: movie)
    }

    func saveToContext(film: FilmDetail) {
        guard let imageData = film.image?.jpegData(compressionQuality: 0.8),
              let context = context,
              view?.movieDetail.firstIndex(where: { $0.filmID == film.filmID }) == nil else { return }
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
