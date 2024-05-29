// MoviesRouter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для взаимодействия с роутером
protocol MoviesRouterProtocol {
    func navigateToDetailScreen(with presenter: MoviesPresenter, id: Int)
}

/// Роутер экрана с фильмами
class MoviesRouter: MoviesRouterProtocol {
    func navigateToDetailScreen(with presenter: MoviesPresenter, id: Int) {
        presenter.selectedMovieID = id
    }
}
