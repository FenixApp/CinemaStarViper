// MoviesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import SwiftData
import UIKit

// swiftlint:disable all

/// Протокол для взаимодействия с презентером
protocol MoviesPresenterProtocol: ObservableObject {
    /// Передача фильмов с интерактора во вью
    func didFetchMovies(_ movies: [Film])
    /// Заявка на получение фильмов с нетворк сервиса
    func prepareMovies(context: ModelContext)

    func goToDetailScreen(with id: Int)
}

/// Презентер экрана с фильмами
class MoviesPresenter: MoviesPresenterProtocol {
    @Published var state: ViewState<[Film]> = .loading
    @Published var selectedMovieID: Int?
    @Published private var moviesToStore: [SwiftDataMovie] = []
    private var context: ModelContext?

    var cancellable: AnyCancellable?

    var view: FilmsView?
    var interactor: MoviesInteractorProtocol?
    var router: MoviesRouterProtocol?

    func didFetchMovies(_ movies: [Film]) {
        state = .data(movies)
        saveToStoredMovies(movies: movies)
    }

    func prepareMovies(context: ModelContext) {
        interactor?.fetchMovies()
        self.context = context
    }

    func goToDetailScreen(with id: Int) {
        router?.navigateToDetailScreen(with: self, id: id)
    }

    func saveToStoredMovies(movies: [Film]) {
        for movie in movies {
            guard let imageData = movie.image?.jpegData(compressionQuality: 0.8) else { return }
            moviesToStore.append(SwiftDataMovie(
                imageUrl: movie.imageUrl ?? "",
                movieName: movie.filmName ?? "",
                rating: movie.rating ?? 0.0,
                id: movie.id,
                image: imageData
            ))
        }
    }

    init() {
        cancellable = $moviesToStore
            .sink { [unowned self] movies in
                for movie in movies {
                    context?.insert(movie)
                }
            }
    }
}

// swiftlint:enable all
