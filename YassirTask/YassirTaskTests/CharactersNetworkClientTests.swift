//
//  YassirTaskTests.swift
//  YassirTaskTests
//
//  Created by Moustafa Hegazy on 11/11/2024.
//

import XCTest
@testable import YassirTask

final class CharactersNetworkClientTests: XCTestCase {

	var charactersNetworkClient: CharactersNetworkClient!

	override func setUp() {
		super.setUp()
		charactersNetworkClient = CharactersNetworkClient()
    }

	override func tearDown() {
		charactersNetworkClient = nil
		super.tearDown()
    }

	func test_fetchData() async throws {
		let expectation = XCTestExpectation(description: "fetch data")

		do {
			let characterData = try await charactersNetworkClient.fetchData(method: "character/"+"?page=1")
			XCTAssertNotNil(characterData)
			expectation.fulfill()
		} catch ( _) {}

		wait(for: [expectation], timeout: 5)

    }

	func test_fetchDataWithInvalidURL() async throws {
		let expectation = XCTestExpectation(description: "fetch data")

		do {
			charactersNetworkClient.baseURL = ""
			_ = try await charactersNetworkClient.fetchData(method: "")
		} catch (let error) {
			XCTAssertNotNil(error)
			expectation.fulfill()
		}

		wait(for: [expectation], timeout: 5)

	}

	func test_fetchDataWithError() async throws {
		let expectation = XCTestExpectation(description: "Test with wrong method")

		do {
			_ = try await charactersNetworkClient.fetchData(method: "1")

		} catch (let error) {
			XCTAssertNotNil(error)
			expectation.fulfill()
		}

		wait(for: [expectation], timeout: 5)


	}

	func test_decodeJSONData() {
		let jsonString = """

{
  "info": {
	"count": 826,
	"pages": 42,
	"next": "https://rickandmortyapi.com/api/character/?page=20",
	"prev": "https://rickandmortyapi.com/api/character/?page=18"
  },
  "results": [
	{
	  "id": 361,
	  "name": "Toxic Rick",
	  "status": "Dead",
	  "species": "Humanoid",
	  "type": "Rick's Toxic Side",
	  "gender": "Male",
	  "origin": {
		"name": "Alien Spa",
		"url": "https://rickandmortyapi.com/api/location/64"
	  },
	  "location": {
		"name": "Earth",
		"url": "https://rickandmortyapi.com/api/location/20"
	  },
	  "image": "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
	  "episode": [
		"https://rickandmortyapi.com/api/episode/27"
	  ],
	  "url": "https://rickandmortyapi.com/api/character/361",
	  "created": "2018-01-10T18:20:41.703Z"
	}
  ]
}

"""

		let jsonData = Data(jsonString.utf8)

		let expectation = XCTestExpectation(description: "Decoding Data")

		do {
			let decodedData: CharactersResponse = try charactersNetworkClient.decodeJSONData(data: jsonData)
			XCTAssertEqual(decodedData.info?.count, 826)
			expectation.fulfill()
		} catch ( _) {}

		wait(for: [expectation], timeout: 5)
	}

	func test_decodeJSONDataWithError() {
		let jsonString = """
"""

		let jsonData = Data(jsonString.utf8)

		let expectation = XCTestExpectation(description: "Decoding Data with error")

		do {
			let _: CharactersResponse = try charactersNetworkClient.decodeJSONData(data: jsonData)
		} catch (let error) {
			XCTAssertNotNil(error)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 5)
	}



}
