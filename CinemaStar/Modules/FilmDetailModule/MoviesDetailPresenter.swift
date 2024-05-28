// MoviesDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///  Протокол для взаимодействия с презентером
protocol MoviesDetailPresenterProtocol: ObservableObject {
    func prepareMovieDetails(by id: Int)
    func didFetchMovieDetail(_ movie: MovieDetail)
}

/// Презентер для  экрана с детальным фильмом
class MoviesDetailPresenter: MoviesDetailPresenterProtocol {
    @Published var state: ViewState<MovieDetail> = .loading

    var view: MoviesDetailViewProtocol?
    var interactor: MoviesDetailInteractorProtocol?
    var router: MoviesDetailRouterProtocol?

    func prepareMovieDetails(by id: Int) {
        interactor?.fetchMovieDetails(by: id)
    }

    func didFetchMovieDetail(_ movie: MovieDetail) {
        state = .data(movie)
    }
}
