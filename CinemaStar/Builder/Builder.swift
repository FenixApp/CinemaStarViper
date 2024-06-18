// Builder.swift

import SwiftUI

/// Сборщик модулей
final class Builder {
    /// Сборка экрана с фильмами
    static func buildFilmsModule() -> some View {
        let presenter = FilmsPresenter()
        let interactor = FilmsInteractor()
        let router = FilmsRouter()
        let networkService = NetworkService()
        let view = FilmsView(presenter: presenter)

        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        interactor.presenter = presenter
        interactor.networkService = networkService

        return view
    }

    /// Сборка экрана с детальным описанием фильма
    static func buildFilmDetailsModule(id: Int) -> some View {
        let interactor = FilmDetailsInteractor()
        let presenter = FilmDetailsPresenter()
        let router = FilmDetailsRouter()
        let networkService = NetworkService()
        var view = FilmDetailsView(presenter: presenter)

        view.id = id
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        interactor.presenter = presenter
        interactor.networkService = networkService

        return view
    }
}
