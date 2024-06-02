// FilmsPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import SwiftData
import SwiftUI

/// Протокол для презентера
protocol FilmsPresenterProtocol: ObservableObject {
    /// Передача фильмов с интерактора во вью
    func didFetchFilms(_ films: [Film])
    /// Запрос на получение фильмов с нетворк сервиса
    func prepareFilms(context: ModelContext)
    /// Переход на экран с детальным описанием фильма
    func goToDetailScreen(with id: Int)
}

/// Презентер экрана с фильмами
final class FilmsPresenter: FilmsPresenterProtocol {
    @Published var state: ViewState<[Film]> = .loading
    @Published var selectedFilmID: Int?

    var cancellable: AnyCancellable?
    var view: FilmsView?
    var interactor: FilmsInteractorProtocol?
    var router: FilmsRouterProtocol?

    @Published private var filmsToStore: [SwiftDataFilm] = []
    private var context: ModelContext?

    func didFetchFilms(_ films: [Film]) {
        state = .data(films)
        saveToStoredFilms(films: films)
    }

    func prepareFilms(context: ModelContext) {
        interactor?.fetchFilms()
        self.context = context
    }

    func goToDetailScreen(with id: Int) {
        router?.navigateToDetailScreen(with: self, id: id)
    }

    func saveToStoredFilms(films: [Film]) {
        for film in films {
            guard let imageData = film.image?.jpegData(compressionQuality: 0.8) else { return }
            filmsToStore.append(SwiftDataFilm(
                imageUrl: film.imageUrl ?? "",
                filmName: film.filmName ?? "",
                rating: film.rating ?? 0.0,
                id: film.id,
                image: imageData
            ))
        }
    }

    init() {
        cancellable = $filmsToStore
            .sink { [unowned self] films in
                for film in films {
                    context?.insert(film)
                }
            }
    }
}
