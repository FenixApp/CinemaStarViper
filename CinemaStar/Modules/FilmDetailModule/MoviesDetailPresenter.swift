// MoviesDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import SwiftData

///  Протокол для взаимодействия с презентером
protocol MoviesDetailPresenterProtocol: ObservableObject {
    func prepareMovieDetails(by id: Int, context: ModelContext)
    func didFetchMovieDetail(_ movie: MovieDetail)
}

/// Презентер для  экрана с детальным фильмом
class MoviesDetailPresenter: MoviesDetailPresenterProtocol {
    @Published var state: ViewState<MovieDetail> = .loading
//    private var movieDetail = PassthroughSubject<SwiftDataMovieDetail, Never>()
    private var context: ModelContext?

    var view: MoviesDetailView?
    var interactor: MoviesDetailInteractorProtocol?
    var router: MoviesDetailRouterProtocol?

    func prepareMovieDetails(by id: Int, context: ModelContext) {
        interactor?.fetchMovieDetails(by: id)
        self.context = context
    }

    func didFetchMovieDetail(_ movie: MovieDetail) {
        state = .data(movie)
        saveToContext(movie: movie)
    }

    func saveToContext(movie: MovieDetail) {
        guard let imageData = movie.image?.jpegData(compressionQuality: 0.8),
              let context = context,
              view?.movieDetail.firstIndex(where: { $0.movieID == movie.movieID }) == nil else { return }
        context.insert(SwiftDataMovieDetail(
            movieName: movie.movieName,
            movieRating: movie.movieRating,
            imageURL: movie.imageURL,
            id: movie.movieID,
            description: movie.description,
            year: movie.year,
            country: movie.country,
            contentType: movie.contentType,
            actors: movie.actors,
            language: movie.language,
            similarMovies: movie.similarMovies,
            image: imageData
        ))
    }
}
