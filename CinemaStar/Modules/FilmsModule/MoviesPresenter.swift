// MoviesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

/// Протокол для взаимосвязи с презентером
protocol MoviesPresenterProtocol: ObservableObject {
    /// Стейт для конфигурации вью
    var state: ViewState<[Movie]> { get set }
    /// Передача фильмов с интерактора во вью
    func didFetchMovies(_ movies: [Movie])
    /// Заявка на получение фильмов с нетворк сервиса
    func prepareMovies()

    func didUpdateMovie(_ movie: Movie)

    func goToDetailScreen(with id: Int)
}

/// Презентер экрана с фильмами
class MoviesPresenter: MoviesPresenterProtocol {
    @Published var state: ViewState<[Movie]> = .loading
    @Published var selectedMovieID: Int?

    var view: MoviesViewProtocol?
    var interactor: MoviesInteractorProtocol?
    var router: MoviesRouterProtocol?

    func didFetchMovies(_ movies: [Movie]) {
        state = .data(movies)
    }

    func prepareMovies() {
        interactor?.fetchMovies()
    }

    func goToDetailScreen(with id: Int) {
        router?.navigateToDetailScreen(with: self, id: id)
    }

    func didUpdateMovie(_ movie: Movie) {
        guard case var .data(movies) = state else { return }
        if let index = movies.firstIndex(where: { $0.id == movie.id }) {
            movies[index] = movie
            state = .data(movies)
        }
    }
}
