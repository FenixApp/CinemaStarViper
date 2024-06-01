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
        saveToContext(movie: movie)
    }

    func saveToContext(movie: FilmDetail) {
        guard let imageData = movie.image?.jpegData(compressionQuality: 0.8),
              let context = context,
              view?.movieDetail.firstIndex(where: { $0.movieID == movie.filmID }) == nil else { return }
        context.insert(SwiftDataMovieDetail(
            movieName: movie.filmName,
            movieRating: movie.filmRating,
            imageURL: movie.imageURL,
            id: movie.filmID,
            description: movie.description,
            year: movie.year,
            country: movie.country,
            contentType: movie.contentType,
            actors: movie.actors,
            language: movie.language,
            similarMovies: movie.similarFilms,
            image: imageData
        ))
    }
}
