// Builder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для создания модулей
protocol BuilderProtocol {
    /// Создание модуля с фильмами
    func makeFilmsModule(coordinator: FilmsCoordinator) -> FilmsViewController
    /// Создание модуля с детальным описанием фильма
    func makeDetailFilmModule(coordinator: FilmsCoordinator, id: Int?) -> FilmDetailViewController
}

/// Билдер приложения
final class Builder: BuilderProtocol {
    func makeFilmsModule(coordinator: FilmsCoordinator) -> FilmsViewController {
        let filmsViewModel = FilmsViewModel(coordinator: coordinator)
        let filmsView = FilmsViewController()
        filmsView.filmsViewModel = filmsViewModel
        return filmsView
    }

    func makeDetailFilmModule(coordinator: FilmsCoordinator, id: Int?) -> FilmDetailViewController {
        let filmDetailViewModel = FilmDetailViewModel(coordinator: coordinator, filmId: id)
        let filmDetailView = FilmDetailViewController()
        filmDetailView.filmDetailViewModel = filmDetailViewModel
        return filmDetailView
    }
}

import SwiftUI

/// Билдер приложения
final class ViewBuilder {
    static func buildMoviesModule() -> some View {
        let presenter = MoviesPresenter()
        let interactor = MoviesInteractor()
        let router = MoviesRouter()
        let networkService = NetworkService()
        let view = MoviesView(presenter: presenter)

        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        interactor.presenter = presenter
        interactor.networkService = networkService

        return view
    }

    static func buildMoviesDetailModule(id: Int) -> some View {
        let interactor = MoviesDetailInteractor()
        let presenter = MoviesDetailPresenter()
        let router = MoviesDetailRouter()
        let networkService = NetworkService()
        var view = MoviesDetailView(presenter: presenter)

        view.id = id
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        interactor.presenter = presenter
        interactor.networkService = networkService

        return view
    }
}
