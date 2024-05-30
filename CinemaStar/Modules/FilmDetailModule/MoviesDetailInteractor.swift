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
                var actors: [MovieActor] = movieDetail.actors
                if let url = URL(string: movieDetail.imageURL ?? "") {
                    networkService?.fetchImage(from: url)
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            switch completion {
                            case .finished:
                                break
                            case let .failure(error):
                                print("Failed to fetch users: \(error.localizedDescription)")
                            }
                        } receiveValue: { [unowned self] image in
                            movieDetail.image = image
                            let group = DispatchGroup()

                            for (index, actor) in actors.enumerated() {
                                guard let url = URL(string: actor.imageURL) else { continue }
                                group.enter()
                                networkService?.fetchImage(from: url)
                                    .receive(on: DispatchQueue.main)
                                    .sink(receiveCompletion: { _ in
                                        group.leave()
                                    }, receiveValue: { image in
                                        if let imageData = image?.jpegData(compressionQuality: 0.8) {
                                            actors[index].image = imageData
                                        }
                                    })
                                    .store(in: &cancellablesSet)
                            }

                            group.notify(queue: .main) {
                                movieDetail.actors = actors
                                self.presenter?.didFetchMovieDetail(movieDetail)
                            }
                        }
                        .store(in: &cancellablesSet)
                }
            })
            .store(in: &cancellablesSet)
    }
}
