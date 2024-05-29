// MoviesInteractor.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import UIKit

/// Протокол для взаимодействия с интерактором
protocol MoviesInteractorProtocol {
    func fetchMovies()
}

/// Интерактор экрана с фильмами
class MoviesInteractor: MoviesInteractorProtocol {
    var presenter: (any MoviesPresenterProtocol)?
    var networkService: NetworkServiceProtocol?

    var cancellablesSet: Set<AnyCancellable> = []

    func fetchMovies() {
        networkService?.fetchMovies()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print("Failed to fetch users: \(error.localizedDescription)")
                }
            }, receiveValue: { [unowned self] moviesDTO in
                let movies = moviesDTO.docs.map { dto -> Movie in
                    var movie = Movie(dto: dto)
                    if let url = movie.imageUrl {
                        networkService?.fetchImage(from: url)
                            .receive(on: DispatchQueue.main)
                            .sink { image in
                                movie.image = image
                                self.presenter?.didUpdateMovie(movie)
                            }
                            .store(in: &cancellablesSet)
                    }
                    return movie
                }
                presenter?.didFetchMovies(movies)

            })
            .store(in: &cancellablesSet)
    }
}
