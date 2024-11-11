//
//  CharactersModel.swift
//  YassirTask
//
//  Created by Moustafa Hegazy on 10/11/2024.
//

import Foundation

// MARK: - CharactersResponse
struct CharactersResponse: Codable {
	let info: ResponseInfo?
	let results: [CharacterModel]?
}


// MARK: - Info
struct ResponseInfo: Codable {
	let count, pages: Int?
	let next, prev: String?
}


// MARK: - Result
struct CharacterModel: Codable {
	let id: Int?
	let name: String?
	let status: Status?
	let species, type: String?
	let gender: Gender?
	let origin, location: Location?
	let image: String?
	let episode: [String]?
	let url: String?
	let created: String?
}

enum Gender: String, Codable {
	case female = "Female"
	case male = "Male"
	case unknown = "unknown"
}

// MARK: - Location
struct Location: Codable {
	let name: String?
	let url: String?
}

enum Status: String, Codable {
	case alive = "Alive"
	case dead = "Dead"
	case unknown = "unknown"
}


struct CharacterUIModel {
	let name: String?
	let image: String?
	let species: String?
	let gender: String?
	let location: String?
	let status: String?
}
