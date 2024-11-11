//
//  CharactersCell.swift
//  YassirTask
//
//  Created by Moustafa Hegazy on 10/11/2024.
//

import SwiftUI

struct CharactersCell: View {

	let characterName: String
	let characterImageUrl: String
	let characterType: String
	let cellID: Int
	let characterStatus: String

	var body: some View {


		HStack(alignment: .top) {


			AsyncImage(url: URL(string: characterImageUrl)) { image in
				image.resizable()
			} placeholder: {
				ProgressView()
			}
			.frame(width: 75, height: 75)
			.clipShape (RoundedRectangle (cornerRadius: 10))



			VStack(alignment: .leading) {
				Text(characterName)
					.bold()
					.accessibilityIdentifier("CharacterCellNameNum\(cellID)_\(characterStatus)")
				Text(characterType).foregroundColor(.gray).accessibilityIdentifier("CharacterCellSpeciesNum\(cellID)_\(characterStatus)")
				Spacer()
			}

			Spacer()

		}
		.padding()
			.overlay(
				RoundedRectangle(cornerRadius: 10)
					.stroke(.gray, lineWidth: 1)
			)




	}
}
