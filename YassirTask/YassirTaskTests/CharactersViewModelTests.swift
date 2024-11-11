//
//  CharactersViewModelTests.swift
//  YassirTaskTests
//
//  Created by Moustafa Hegazy on 11/11/2024.
//

import XCTest
@testable import YassirTask


final class CharactersViewModelTests: XCTestCase {

	var viewModel: CharactersViewModel!

    override func setUp() {
		super.setUp()
		viewModel = CharactersViewModel(charactersRepo: MockedRepo(networkClient: MockedNetworkClient()))
    }

    override func tearDown() {
		viewModel = nil
		super.tearDown()
    }



	func test_getCharactersInPage() async {

			await viewModel.getCharactersInPage(pageNumber: 1)

			XCTAssertEqual(viewModel.numberOfAvailablePages, 42)
			XCTAssertEqual(viewModel.getCharactersCount(), 1)

	}

	func test_getCharactersCountWithDeadFilter() async {

		viewModel.isFiltered = true
		await viewModel.getCharactersInPage(pageNumber: 1)

		viewModel.applyFilter(index: 0)

		XCTAssertEqual(viewModel.getCharactersCount(), 1)

	}

	func test_getCharactersCountWithAliveFilter() async {

		viewModel.isFiltered = true
		await viewModel.getCharactersInPage(pageNumber: 1)

		viewModel.applyFilter(index: 1)

		XCTAssertEqual(viewModel.getCharactersCount(), 0)

	}

	func test_getCharactersCountWithUnknownFilter() async {

		viewModel.isFiltered = true
		await viewModel.getCharactersInPage(pageNumber: 1)

		viewModel.applyFilter(index: 2)

		XCTAssertEqual(viewModel.getCharactersCount(), 0)

	}


	func test_CancelFilter() async {

		viewModel.isFiltered = true

		viewModel.cancelFilter()

		XCTAssertFalse(viewModel.isFiltered)

	}



}

struct MockedRepo: CharactersRepositoryProtocol {

	var networkClient: YassirTask.NetworkClient

	func getCharactersByPageNumber(pageNumber: Int) async throws -> ([YassirTask.CharacterModel], Int) {
		let characterData = try await networkClient.fetchData(method: "")

		let responseModel: CharactersResponse = try networkClient.decodeJSONData(data: characterData)

		return (responseModel.results ?? [], responseModel.info?.pages ?? 0 )

	}


}
