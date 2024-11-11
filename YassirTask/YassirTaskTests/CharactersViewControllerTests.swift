//
//  CharactersViewControllerTests.swift
//  YassirTaskTests
//
//  Created by Moustafa Hegazy on 11/11/2024.
//

import XCTest
@testable import YassirTask

final class CharactersViewControllerTests: XCTestCase {

	var characterVC: CharactersViewController!

    override func setUp() {
		super.setUp()

		characterVC = UIStoryboard(
			name: "Main", bundle:nil).instantiateViewController(
				withIdentifier: "CharacterViewController") as? CharactersViewController

		_ = characterVC.view
    }

    override func tearDown() {
		characterVC = nil
		super.tearDown()
    }


	func test_makeFilter() {

		// selecting dead
		characterVC.makeFilter(index: 0)

		XCTAssertEqual(characterVC.title, "DeadChar".localized())

		// selecting Alive
		characterVC.makeFilter(index: 1)

		XCTAssertEqual(characterVC.title, "AliveChar".localized())

		// selecting unknown
		characterVC.makeFilter(index: 2)

		XCTAssertEqual(characterVC.title, "UnknownChar".localized())

		// selecting the same previous value
		characterVC.makeFilter(index: 2)

		XCTAssertEqual(characterVC.title, "CharactersTitle".localized())


		// selecting default
		characterVC.makeFilter(index: 3)

		XCTAssertEqual(characterVC.title, "CharactersTitle".localized())

	}

}
