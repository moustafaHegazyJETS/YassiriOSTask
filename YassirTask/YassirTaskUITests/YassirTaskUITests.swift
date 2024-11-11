//
//  YassirTaskUITests.swift
//  YassirTaskUITests
//
//  Created by Moustafa Hegazy on 11/11/2024.
//

import XCTest

final class YassirTaskUITests: XCTestCase {

	let app = XCUIApplication()

    override func setUp() {
		super.setUp()
        continueAfterFailure = false

		let app = XCUIApplication()
		app.launch()
    }

    override func tearDown() {
		super.tearDown()
    }

    func testLoadingCharacters() {
        // UI tests must launch the application that they test.

		let tablesQuery = app.tables

		let firstCellTitle = tablesQuery.staticTexts["CharacterCellNameNum1_Alive"]

		XCTAssert(firstCellTitle.waitForExistence(timeout: 5))

		let firstCellSubTitle = tablesQuery.staticTexts["CharacterCellSpeciesNum1_Alive"]

		XCTAssert(firstCellSubTitle.waitForExistence(timeout: 5))
    }


	func testSelectFilterCell() {

		let deadFilterCell = app.buttons["FilterCell_Dead"]

		XCTAssert(deadFilterCell.waitForExistence(timeout: 5))

		deadFilterCell.tap()


		// check if filter works

		let tablesQuery = app.tables

		let firstCellTitle = tablesQuery.staticTexts["CharacterCellNameNum1_Dead"].waitForExistence(timeout: 5)

		XCTAssert(firstCellTitle)

		let firstCellSubTitle = tablesQuery.staticTexts["CharacterCellSpeciesNum1_Dead"].waitForExistence(timeout: 5)

		XCTAssert(firstCellSubTitle)

	}

	func testOpenDetailsView() {
		let tablesQuery = app.tables

		let firstCellTitle = tablesQuery.staticTexts["CharacterCellNameNum1_Alive"]

		XCTAssert(firstCellTitle.waitForExistence(timeout: 5))

		firstCellTitle.tap()

		let characterStatusLabel = app.staticTexts["CharacterStatusLabel"]

		XCTAssert(characterStatusLabel.waitForExistence(timeout: 5))

		let characterNameLabel = app.staticTexts["CharacterNameLabel"]

		XCTAssert(characterNameLabel.waitForExistence(timeout: 5))

		let backButton = app.buttons["CharacterDetailsBackButton"]

		XCTAssert(backButton.waitForExistence(timeout: 5))

		backButton.tap()


		XCTAssert(firstCellTitle.waitForExistence(timeout: 5))

	}


}
