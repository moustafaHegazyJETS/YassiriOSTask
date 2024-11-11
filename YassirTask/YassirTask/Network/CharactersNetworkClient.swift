//
//  CharactersNetworkClient.swift
//  YassirTask
//
//  Created by Moustafa Hegazy on 10/11/2024.
//

import Foundation

enum NetworkHandlerError: Error {
	case InvalidURL
	case JSONDecodingError
	case RequestError(String)
	case UnknownError
}

struct Info: Codable {
	let count: Int
	let pages: Int
	let next: String?
	let prev: String?
}

struct ResponseErrorMessage: Codable {
	let error: String
}

protocol NetworkClient {
	func fetchData(method: String) async throws -> Data
	func decodeJSONData<T: Codable>(data: Data) throws -> T
}

public struct CharactersNetworkClient: NetworkClient {
	var baseURL: String = "https://rickandmortyapi.com/api/"

	func fetchData(method: String) async throws -> Data {
		if let url = URL(string: baseURL+method) {
			let (data, response) = try await URLSession.shared.data(from: url)
			guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
				let error: ResponseErrorMessage = try decodeJSONData(data: data)
				throw NetworkHandlerError.RequestError(error.error)
			}
			return data
		} else {
			throw(NetworkHandlerError.InvalidURL)
		}
	}

	func decodeJSONData<T: Codable>(data: Data) throws -> T {
		let decoder = JSONDecoder()
		do {
			let decodedData = try decoder.decode(T.self, from: data)
			return decodedData
		} catch {
			throw NetworkHandlerError.JSONDecodingError
		}
	}
}
