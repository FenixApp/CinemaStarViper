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
