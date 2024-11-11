//
//  CharactersRepository.swift
//  YassirTask
//
//  Created by Moustafa Hegazy on 10/11/2024.
//

import Foundation


// here is the repo which used to select how to fetch data from cache or from network client
// init takes network client protocol


protocol CharactersRepositoryProtocol {
	var networkClient: NetworkClient { get set }
	func getCharactersByPageNumber(pageNumber: Int) async throws -> ([CharacterModel], Int)
}


struct CharactersRepository: CharactersRepositoryProtocol {

	var networkClient: NetworkClient


	func getCharactersByPageNumber(pageNumber: Int) async throws -> ([CharacterModel], Int) {

		let characterData = try await networkClient.fetchData(method: "character/"+"?page="+String(pageNumber))

		let responseModel: CharactersResponse = try networkClient.decodeJSONData(data: characterData)

		return (responseModel.results ?? [], responseModel.info?.pages ?? 0 )
	}
	

}
