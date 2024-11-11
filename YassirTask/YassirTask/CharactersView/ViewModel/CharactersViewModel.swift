//
//  CharactersViewModel.swift
//  YassirTask
//
//  Created by Moustafa Hegazy on 10/11/2024.
//

import Foundation

class CharactersViewModel {

	let charactersRepo: CharactersRepositoryProtocol

	private var charactersArray: [CharacterModel] = []

	private var filteredCharactersArray: [CharacterModel] = []

	var numberOfAvailablePages: Int?

	var isFiltered = false


	init(
		charactersRepo: CharactersRepositoryProtocol = CharactersRepository(
			networkClient: CharactersNetworkClient()
		)
	) {
		self.charactersRepo = charactersRepo
	}


	func getCharactersInPage(pageNumber: Int) async {
//		if !isFiltered {
			do {
				let result: ([CharacterModel], Int) = try await charactersRepo.getCharactersByPageNumber(pageNumber: pageNumber)
				charactersArray.append(contentsOf: result.0)
				numberOfAvailablePages = result.1
			} catch {
				// SHOW error on ui
			}
//		}
	}

	// add get count
	func getCharactersCount() -> Int {
		return isFiltered ? filteredCharactersArray.count : charactersArray.count
	}

	// add get cell data
	func getCellData(index: Int) -> CharacterModel {

		return isFiltered ? filteredCharactersArray[index] : charactersArray[index]
	}

	// add get filteration array


	func applyFilter(index: Int) {
		isFiltered = true
		switch index {
		case 0:
			filteredCharactersArray = charactersArray.filter({ $0.status?.rawValue ?? "" == Status.dead.rawValue })
		case 1:
			filteredCharactersArray = charactersArray.filter({ $0.status?.rawValue ?? "" == Status.alive.rawValue })
		case 2:
			filteredCharactersArray = charactersArray.filter({ $0.status?.rawValue ?? "" == Status.unknown.rawValue })
		default:
			print("no filteration")
		}
	}

	func cancelFilter() {
		isFiltered = false
		filteredCharactersArray = []
	}


// here we use the repo to get the characters and to make the api call when filtiring it
	// init should pass the repo protocol
}
