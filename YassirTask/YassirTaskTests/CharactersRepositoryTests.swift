//
//  CharactersRepositoryTests.swift
//  YassirTaskTests
//
//  Created by Moustafa Hegazy on 11/11/2024.
//

import XCTest
@testable import YassirTask

final class CharactersRepositoryTests: XCTestCase {

	var characterRepo: CharactersRepositoryProtocol!

	let mockedNetworkClient = MockedNetworkClient()

    override func setUp() {
		super.setUp()

		characterRepo = CharactersRepository(networkClient: mockedNetworkClient)
    }

    override func tearDown() {
		characterRepo = nil
		super.tearDown()
    }

	func test_getCharactersByPageNumber() async {
		
		let expectation = XCTestExpectation(description: "Getting data successfully")

		do {
			let decodedData = try await characterRepo.getCharactersByPageNumber(pageNumber: 1)
			XCTAssertEqual(decodedData.0.first?.name, "Toxic Rick")
			XCTAssertEqual(decodedData.1, 42)
			expectation.fulfill()
		} catch ( _) {}

		wait(for: [expectation], timeout: 5)
	}

}


struct MockedNetworkClient: NetworkClient {
	func fetchData(method: String) async throws -> Data {
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

		return jsonData
	}

	func decodeJSONData<T>(data: Data) throws -> T where T : Decodable, T : Encodable {
		let decoder = JSONDecoder()
		do {
			let decodedData = try decoder.decode(T.self, from: data)
			return decodedData
		} catch {
			throw NetworkHandlerError.JSONDecodingError
		}

	}


}
