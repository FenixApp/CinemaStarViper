// FilmsInteractorTests.swift

@testable import CinemaStar
import Combine
import SwiftData
import XCTest

// Mock NetworkService
class MockNetworkService: NetworkServiceProtocol {
    func fetchFilm(by id: Int) -> AnyPublisher<CinemaStar.FilmDTO, any Error> {
        fetchFilmResult.publisher.eraseToAnyPublisher()
    }

    func fetchFilms() -> AnyPublisher<FilmsDTO, any Error> {
        fetchFilmsResult.publisher.eraseToAnyPublisher()
    }

    func fetchImage(from url: URL) -> AnyPublisher<UIImage?, any Error> {
        fetchImageResult.publisher.eraseToAnyPublisher()
    }

    var fetchFilmsResult: Result<FilmsDTO, Error>!
    var fetchFilmResult: Result<FilmDTO, Error>!
    var fetchImageResult: Result<UIImage?, Error>!
}

// Mock Presenter
class MockFilmsPresenter: FilmsPresenterProtocol {
    func prepareFilms(context: ModelContext) {}
    func goToDetailScreen(with id: Int) {}

    var didFetchFilms = false
    var fetchedFilms: [Film]?

    func didFetchFilms(_ films: [Film]) {
        didFetchFilms = true
        fetchedFilms = films
    }
}

final class FilmsInteractorTests: XCTestCase {
    var interactor: FilmsInteractor!
    var mockNetworkService: MockNetworkService!
    var mockPresenter: MockFilmsPresenter!

    override func setUp() {
        super.setUp()
        interactor = FilmsInteractor()
        mockNetworkService = MockNetworkService()
        mockPresenter = MockFilmsPresenter()
        interactor.networkService = mockNetworkService
        interactor.presenter = mockPresenter
    }

    override func tearDown() {
        interactor = nil
        mockNetworkService = nil
        mockPresenter = nil
        super.tearDown()
    }

    func testFetchFilmsSuccess() {
        let filmsDTO = FilmsDTO(docs: [
            FilmDTO(
                name: "Fallout",
                id: 54321,
                poster: PosterDTO(url: "woeuwgoewgowe"),
                rating: RatingDTO(kp: 10),
                description: "Fallout - war never changes",
                year: 2024,
                countries: nil,
                type: nil,
                persons: nil,
                spokenLanguages: nil,
                similarFilms: nil
            ),
            FilmDTO(
                name: "Terminator 2",
                id: 12345,
                poster: PosterDTO(url: "fgqwgewegh"),
                rating: RatingDTO(kp: 9.9),
                description: "Judgment Day",
                year: 1991,
                countries: nil,
                type: nil,
                persons: nil,
                spokenLanguages: nil,
                similarFilms: nil
            )
        ])
        let image = UIImage()
        mockNetworkService.fetchFilmsResult = .success(filmsDTO)
        mockNetworkService.fetchImageResult = .success(image)

        let expectation = self.expectation(description: "fetchFilms")

        interactor.fetchFilms()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertTrue(mockPresenter.didFetchFilms)
        XCTAssertEqual(mockPresenter.fetchedFilms?.count, 2)
        XCTAssertEqual(mockPresenter.fetchedFilms?.first?.filmName, "Fallout")
        XCTAssertEqual(mockPresenter.fetchedFilms?.last?.filmName, "Terminator 2")
        XCTAssertEqual(mockPresenter.fetchedFilms?.last?.image, image)
    }

    func testFetchFilmsFailure() {
        let error = NSError(domain: "testError", code: 1, userInfo: nil)
        mockNetworkService.fetchFilmsResult = .failure(error)

        let expectation = self.expectation(description: "fetchFilms")

        interactor.fetchFilms()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertFalse(mockPresenter.didFetchFilms)
    }
}
