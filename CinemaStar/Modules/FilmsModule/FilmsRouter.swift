// FilmsRouter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для взаимодействия с роутером
protocol FilmsRouterProtocol {
    func navigateToDetailScreen(with presenter: FilmsPresenter, id: Int)
}

/// Роутер экрана с фильмами
class FilmsRouter: FilmsRouterProtocol {
    func navigateToDetailScreen(with presenter: FilmsPresenter, id: Int) {
        presenter.selectedFilmID = id
    }
}
