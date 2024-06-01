// FilmDetailInteractorTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import CinemaStar
import Combine
import SwiftData
import XCTest

// Mock Presenter
class MockFilmDetailPresenter: FilmDetailsPresenterProtocol {
    func prepareFilmDetails(by id: Int, context: ModelContext) {}

    var didFetchMovieDetail = false
    var fetchedMovieDetail: FilmDetail?

    func didFetchFilmDetail(_ movieDetail: FilmDetail) {
        didFetchMovieDetail = true
        fetchedMovieDetail = movieDetail
    }
}

final class FilmDetailInteractorTests: XCTestCase {
    var interactor: FilmDetailsInteractor!
    var mockNetworkService: MockNetworkService!
    var mockPresenter: MockFilmDetailPresenter!

    override func setUp() {
        super.setUp()
        interactor = FilmDetailsInteractor()
        mockNetworkService = MockNetworkService()
        mockPresenter = MockFilmDetailPresenter()
        interactor.networkService = mockNetworkService
        interactor.presenter = mockPresenter
    }

    override func tearDown() {
        interactor = nil
        mockNetworkService = nil
        mockPresenter = nil
        super.tearDown()
    }

    func testFetchMovieDetailsSuccess() {
        let movieDTO = FilmDTO(
            name: "Avengers",
            id: 12345,
            poster: PosterDTO(url: "https://marvel.com/avengers.jpg"),
            rating: RatingDTO(kp: 10),
            description: "Marvel Avengers",
            year: 2012,
            countries: nil,
            type: nil,
            persons: [
                PersonDTO(name: "Robert Downey Jr.", photo: nil)
            ],
            spokenLanguages: nil,
            similarFilms: nil
        )
        let movieImage = UIImage()
        mockNetworkService.fetchMovieResult = .success(movieDTO)
        mockNetworkService.fetchImageResult = .success(movieImage)

        let expectation = self.expectation(description: "fetchFilmDetails")

        interactor.fetchFilmDetails(by: 12345)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertTrue(mockPresenter.didFetchMovieDetail)
        XCTAssertEqual(mockPresenter.fetchedMovieDetail?.year, 2012)
        XCTAssertEqual(mockPresenter.fetchedMovieDetail?.filmName, "Avengers")
        XCTAssertEqual(mockPresenter.fetchedMovieDetail?.image, movieImage)
        XCTAssertEqual(mockPresenter.fetchedMovieDetail?.filmRating, 10)
        XCTAssertEqual(mockPresenter.fetchedMovieDetail?.actors.first?.name, "Robert Downey Jr.")
    }

    func testFetchMovieDetailsFailure() {
        let error = NSError(domain: "testError", code: 1, userInfo: nil)
        mockNetworkService.fetchMovieResult = .failure(error)

        let expectation = self.expectation(description: "fetchFilmDetails")

        interactor.fetchFilmDetails(by: 12345)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertFalse(mockPresenter.didFetchMovieDetail)
    }
}
