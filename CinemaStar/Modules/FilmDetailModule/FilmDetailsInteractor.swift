// FilmDetailsInteractor.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

/// Протокол для интерактора
protocol FilmDetailsInteractorProtocol {
    func fetchFilmDetails(by id: Int)
}

/// Интерактор для экрана с детальным описанием фильма
final class FilmDetailsInteractor: FilmDetailsInteractorProtocol {
    enum Constant {
        static let noText = ""
    }

    var presenter: (any FilmDetailsPresenterProtocol)?
    var networkService: NetworkServiceProtocol?
    var cancellablesSet: Set<AnyCancellable> = []

    func fetchFilmDetails(by id: Int) {
        networkService?.fetchFilm(by: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print("Failed to fetch users: \(error.localizedDescription)")
                }
            }, receiveValue: { [unowned self] filmDTO in
                var filmDetail = FilmDetail(dto: filmDTO)
                var actors: [FilmActor] = filmDetail.actors
                if let url = URL(string: filmDetail.imageURL ?? Constant.noText) {
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
                            filmDetail.image = image
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
                                filmDetail.actors = actors
                                self.presenter?.didFetchFilmDetail(filmDetail)
                            }
                        }
                        .store(in: &cancellablesSet)
                }
            })
            .store(in: &cancellablesSet)
    }
}
