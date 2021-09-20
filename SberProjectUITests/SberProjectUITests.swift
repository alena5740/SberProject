//
//  SberProjectUITests.swift
//  SberProjectUITests
//
//  Created by Алена on 05.08.2021.
//

import XCTest

class SberProjectUITests: XCTestCase {
    var app: XCUIApplication!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }

    // MARK: - Tests

    func testChekingEqualFriendsNavigationTitle() {
        app.launch()
        sleep(2)

        // Tap the "Done" button
        app.buttons["Мои друзья"].tap()
        
        let text = app.staticTexts["Мои друзья"]
        XCTAssertTrue("Мои друзья" == text.label, "Текст не идентичен")
    }
    
    func testChekingNoEqualFriendsNavigationTitle() {
        app.launch()
        sleep(2)

        // Tap the "Done" button
        app.buttons["Мои друзья"].tap()
        
        let text = app.staticTexts["Мои друзья"]
        XCTAssertFalse("1Мои друзья" == text.label, "Текст идентичен")
    }
}
