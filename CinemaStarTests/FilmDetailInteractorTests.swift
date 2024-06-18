// FilmDetailInteractorTests.swift

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
            name: "Fallout",
            id: 54321,
            poster: PosterDTO(url: "https://upload.wikimedia.org/wikipedia/ru/f/f0/Fallout_Amazon_poster.jpeg"),
            rating: RatingDTO(kp: 10),
            description: "Fallout - war never changes",
            year: 2024,
            countries: nil,
            type: nil,
            persons: [
                PersonDTO(name: "Ella Purnell", photo: nil)
            ],
            spokenLanguages: nil,
            similarFilms: nil
        )
        let filmImage = UIImage()
        mockNetworkService.fetchFilmResult = .success(filmDTO)
        mockNetworkService.fetchImageResult = .success(filmImage)

        let expectation = self.expectation(description: "fetchFilmDetails")

        interactor.fetchFilmDetails(by: 54321)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertTrue(mockPresenter.didFetchFilmDetail)
        XCTAssertEqual(mockPresenter.fetchedFilmDetail?.year, 2024)
        XCTAssertEqual(mockPresenter.fetchedFilmDetail?.filmName, "Fallout")
        XCTAssertEqual(mockPresenter.fetchedFilmDetail?.image, filmImage)
        XCTAssertEqual(mockPresenter.fetchedFilmDetail?.filmRating, 10)
        XCTAssertEqual(mockPresenter.fetchedFilmDetail?.actors.first?.name, "Ella Purnell")
    }

    func testFetchFilmDetailsFailure() {
        let error = NSError(domain: "testError", code: 1, userInfo: nil)
        mockNetworkService.fetchFilmResult = .failure(error)

        let expectation = self.expectation(description: "fetchFilmDetails")

        interactor.fetchFilmDetails(by: 54321)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertFalse(mockPresenter.didFetchFilmDetail)
    }
}
