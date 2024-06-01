// FilmDetailInteractorTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import CinemaStar
import Combine
import SwiftData
import XCTest

// Mock Presenter
class MockFilmDetailPresenter: FilmDetailsPresenterProtocol {
    func prepareFilmDetails(by id: Int, context: ModelContext) {}

    var didFetchFilmDetail = false
    var fetchedFilmDetail: FilmDetail?

    func didFetchFilmDetail(_ filmDetail: FilmDetail) {
        didFetchFilmDetail = true
        fetchedFilmDetail = filmDetail
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

    func testFetchFilmDetailsSuccess() {
        let filmDTO = FilmDTO(
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
        let filmImage = UIImage()
        mockNetworkService.fetchFilmResult = .success(filmDTO)
        mockNetworkService.fetchImageResult = .success(filmImage)

        let expectation = self.expectation(description: "fetchFilmDetails")

        interactor.fetchFilmDetails(by: 12345)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertTrue(mockPresenter.didFetchFilmDetail)
        XCTAssertEqual(mockPresenter.fetchedFilmDetail?.year, 2012)
        XCTAssertEqual(mockPresenter.fetchedFilmDetail?.filmName, "Avengers")
        XCTAssertEqual(mockPresenter.fetchedFilmDetail?.image, filmImage)
        XCTAssertEqual(mockPresenter.fetchedFilmDetail?.filmRating, 10)
        XCTAssertEqual(mockPresenter.fetchedFilmDetail?.actors.first?.name, "Robert Downey Jr.")
    }

    func testFetchFilmDetailsFailure() {
        let error = NSError(domain: "testError", code: 1, userInfo: nil)
        mockNetworkService.fetchFilmResult = .failure(error)

        let expectation = self.expectation(description: "fetchFilmDetails")

        interactor.fetchFilmDetails(by: 12345)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertFalse(mockPresenter.didFetchFilmDetail)
    }
}
