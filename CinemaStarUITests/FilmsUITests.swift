// FilmsUITests.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

final class FilmsUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {}

    /// Тест на скроллинг
    func testScrollFilms() throws {
        let horizontalScrollBar1PageCollectionView = XCUIApplication().collectionViews.containing(
            .other,
            identifier: "Horizontal scroll bar, 1 page"
        ).element
        horizontalScrollBar1PageCollectionView.swipeDown()
        horizontalScrollBar1PageCollectionView.swipeUp()
        horizontalScrollBar1PageCollectionView.swipeDown()
        horizontalScrollBar1PageCollectionView.swipeUp()
    }

    /// Тест на тап и переход к другому экрану
    func testGoToDetailsScreen() {
        let app = XCUIApplication()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier: "Демон революции\n⭐️  6.2").element
            .tap()
        app.navigationBars["CinemaStar.FilmDetailView"].buttons["Back"].tap()
    }
}
