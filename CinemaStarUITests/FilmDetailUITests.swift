// FilmDetailUITests.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

// swiftlint:disable all
final class FilmDetailUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {}

    /// Тест на тап и скролл
    func testGoToDetailsScreen() {
        let app = XCUIApplication()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier: "Орда\n⭐️  6.1")
            .element.tap()

        let tablesQuery = app.tables
        let staticText = tablesQuery/*@START_MENU_TOKEN@*/
            .staticTexts["Орда\n⭐️  6.1"]/*[[".cells.staticTexts[\"Орда\\n⭐️  6.1\"]",".staticTexts[\"Орда\\n⭐️  6.1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        staticText.tap()
        staticText.swipeUp()
        staticText.swipeDown()
        staticText.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/
            .staticTexts["Смотреть"]/*[[".cells",".buttons[\"Смотреть\"].staticTexts[\"Смотреть\"]",".staticTexts[\"Смотреть\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
            .tap()
        app.alerts["Упс!"].scrollViews.otherElements.buttons["Ок"].tap()

        let staticText2 = app.tables/*@START_MENU_TOKEN@*/
            .staticTexts["Царь"]/*[[".cells.staticTexts[\"Царь\"]",".staticTexts[\"Царь\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        staticText2.tap()
        staticText2.swipeLeft()
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other)
            .element.children(matching: .other).element.children(matching: .other).element.children(matching: .other)
            .element.swipeRight()
    }

    func scrolling() {}
}

// swiftlint:enable all
