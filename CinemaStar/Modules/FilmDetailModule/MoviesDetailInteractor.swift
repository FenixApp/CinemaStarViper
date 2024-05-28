// MoviesDetailInteractor.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

///  Протокол для взаимодействия с интерактором
protocol MoviesDetailInteractorProtocol {
    func fetchMovieDetails(by id: Int)
}

/// Интерактор для  экрана с детальным фильмом
class MoviesDetailInteractor: MoviesDetailInteractorProtocol {
    var presenter: (any MoviesDetailPresenterProtocol)?
    var networkService: NetworkServiceProtocol?

    var cancellablesSet: Set<AnyCancellable> = []

    func fetchMovieDetails(by id: Int) {
        networkService?.fetchMovie(by: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print("Failed to fetch users: \(error.localizedDescription)")
                }
            }, receiveValue: { [unowned self] movieDTO in
                var movieDetail = MovieDetail(dto: movieDTO)
                if let url = movieDetail.imageURL {
                    networkService?.fetchImage(from: url)
                        .receive(on: DispatchQueue.main)
                        .sink { image in
                            movieDetail.image = image
                            self.presenter?.didFetchMovieDetail(movieDetail)
                        }
                        .store(in: &cancellablesSet)
                }
            })
            .store(in: &cancellablesSet)
    }
}
