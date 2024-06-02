// FilmsRouter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для роутера
protocol FilmsRouterProtocol {
    func navigateToDetailScreen(with presenter: FilmsPresenter, id: Int)
}

/// Роутер экрана с фильмами
final class FilmsRouter: FilmsRouterProtocol {
    func navigateToDetailScreen(with presenter: FilmsPresenter, id: Int) {
        presenter.selectedFilmID = id
    }
}
