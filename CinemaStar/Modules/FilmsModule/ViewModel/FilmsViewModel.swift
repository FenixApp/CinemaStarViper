// FilmsViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью модели для основного экрана со списком фильмов
protocol FilmsViewModelProtocol {
    /// Инициализация координатора
    init(coordinator: FilmsCoordinator)
    /// Состояние View
    var updateViewState: ((ViewState<[Film]>) -> ())? { get set }
    /// Запуск загрузки данных
    func startFetch()
    /// Детальная информация о фильме с идентификатором фильма
    func showDetailFilm(id: Int?)
}

final class FilmsViewModel: FilmsViewModelProtocol {
    // MARK: - Public Properties

    public var updateViewState: ((ViewState<[Film]>) -> ())?

    // MARK: - Private Properties

    private let coordinator: FilmsCoordinator?
    private var filmsRequest: APIRequest<FilmResource>?

    // MARK: - Initializers

    init(coordinator: FilmsCoordinator) {
        updateViewState?(.loading)
        self.coordinator = coordinator
    }

    // MARK: - Public Methods

    func startFetch() {
        let apiResource = FilmResource(
            methodPath: "/search",
            queryItems: [URLQueryItem(name: "query", value: "История")]
        )
        filmsRequest = APIRequest(resource: apiResource)
        filmsRequest?.execute(withCompletion: { [weak self] filmListDTO in
            guard let filmListDTO else { return }
            var films: [Film] = []
            for filmDTO in filmListDTO.docs {
                films.append(Film(filmDTO: filmDTO))
            }
            self?.updateViewState?(.data(films))
        })
    }

    func showDetailFilm(id: Int?) {
        coordinator?.pushFilmDetailView(id: id)
    }
}
