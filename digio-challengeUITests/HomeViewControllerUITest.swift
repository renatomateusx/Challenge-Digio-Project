//
//  HomeViewControllerUITests.swift
//  HomeViewControllerUITests
//
//  Created by Renato Mateus on 08/11/21.
//

import XCTest

class HomeViewControllerUITest: XCTestCase {

    func testTableResults() {
        let app = XCUIApplication()
        app.launch()
        _ = app.tables.firstMatch.waitForExistence(timeout: 5)
        let cellCount = app.tables.cells.count
        XCTAssertTrue(cellCount > 0)
    }
    
    func testTapTableViewCell() {
        let app = XCUIApplication()
        app.launch()
        let cell = app.tables.cells.element(boundBy: 2)
        XCTAssertTrue(cell.exists)
        cell.tap()
    }
    
    func testSwipeDownNavigation() {
        let app = XCUIApplication()
        app.launch()
        let cell = app.tables.cells.element(boundBy: 2)
        XCTAssertTrue(cell.exists)
        cell.tap()
        app.swipeDown()
    }
    
    func testLoadMore() {
        let app = XCUIApplication()
        app.launch()
        _ = app.tables.firstMatch.waitForExistence(timeout: 5)
        let firstCount = app.tables.staticTexts.count
        app.tables.firstMatch.swipeUp()
        var afterCount = app.tables.staticTexts.count
        afterCount += 5
        XCTAssertTrue(afterCount > firstCount)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
