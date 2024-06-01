// FilmsInteractor.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import SwiftData
import SwiftUI

/// Протокол для интерактора
protocol FilmsInteractorProtocol {
    func fetchFilms()
}

/// Интерактор экрана с фильмами
final class FilmsInteractor: FilmsInteractorProtocol {
    var presenter: (any FilmsPresenterProtocol)?
    var networkService: NetworkServiceProtocol?
    var cancellablesSet: Set<AnyCancellable> = []

    func fetchFilms() {
        networkService?.fetchFilms()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print("Failed to fetch users: \(error.localizedDescription)")
                }
            }, receiveValue: { [unowned self] filmsDTO in
                var films = filmsDTO.docs.map { Film(dto: $0) }

                let group = DispatchGroup()

                for (index, film) in films.enumerated() {
                    if let url = URL(string: film.imageUrl ?? "") {
                        group.enter()
                        networkService?.fetchImage(from: url)
                            .receive(on: DispatchQueue.main)
                            .sink(receiveCompletion: { _ in
                                group.leave()
                            }, receiveValue: { image in
                                films[index].image = image
                            })
                            .store(in: &cancellablesSet)
                    }
                }
                group.notify(queue: .main) {
                    self.presenter?.didFetchFilms(films)
                }
            })
            .store(in: &cancellablesSet)
    }
}
