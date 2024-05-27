// FilmDetailViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью модели для детального экрана с фильмом
protocol FilmDetailViewModelProtocol {
    /// Инициализация координатора
    init(coordinator: FilmsCoordinator, filmId: Int?)
    /// Состояние View
    var updateViewState: ((ViewState<FilmDetail>) -> ())? { get set }
    /// Запуск загрузки данных
    func startFetch()
}

final class FilmDetailViewModel: FilmDetailViewModelProtocol {
    // MARK: - Public Properties

    public var updateViewState: ((ViewState<FilmDetail>) -> ())?

    var isFavoriteFilm: Bool {
        guard let filmId else { return false }
        return UserDefaults.standard.value(forKey: "\(filmId)") != nil
    }

    // MARK: - Private Properties

    private let coordinator: FilmsCoordinator?
    private let filmId: Int?
    private var filmDetailRequest: APIRequest<FilmDetailResource>?

    // MARK: - Initializers

    init(coordinator: FilmsCoordinator, filmId: Int?) {
        updateViewState?(.loading)
        self.coordinator = coordinator
        self.filmId = filmId
    }

    // MARK: - Public Methods

    func startFetch() {
        guard let filmId else { return }
        let filmDetailResource = FilmDetailResource(methodPath: "/\(filmId)")
        filmDetailRequest = APIRequest(resource: filmDetailResource)
        filmDetailRequest?.execute(withCompletion: { [weak self] filmDetailDTO in
            guard let filmDetailDTO else { return }
            let filmDetail = FilmDetail(filmDetailDTO: filmDetailDTO)
            self?.updateViewState?(.data(filmDetail))
        })
    }
}
