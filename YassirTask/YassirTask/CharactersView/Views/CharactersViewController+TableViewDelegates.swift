//
//  CharactersViewController+TableViewDelegates.swift
//  YassirTask
//
//  Created by Moustafa Hegazy on 10/11/2024.
//

import Foundation
import UIKit
import SwiftUI

extension CharactersViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel?.getCharactersCount() ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID,
												 for: indexPath)

		guard let viewModel = viewModel else { return UITableViewCell() }

		let cellModel = viewModel.getCellData(index: indexPath.row)
		cell.contentConfiguration = UIHostingConfiguration(content: {
			CharactersCell(
				characterName: cellModel.name ?? "",
				characterImageUrl: cellModel.image ?? "",
				characterType: cellModel.species ?? "",
				cellID: indexPath.row,
				characterStatus: cellModel.status?.rawValue ?? ""
			)
		})
		cell.selectionStyle = .none


		return cell
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		guard let viewModel = viewModel else { return }

		if indexPath.row == viewModel.getCharactersCount() - 1,
		   pageNumber < viewModel.numberOfAvailablePages ?? 0, lastSelectedFilterIndex == nil {
			fetchData()
		}
	}


}

extension CharactersViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailsViewController = CharacterDetailsViewController(	)

		guard let viewModel = viewModel else { return }

		detailsViewController.modalPresentationStyle = .fullScreen

		let model = viewModel.getCellData(index: indexPath.row)

		detailsViewController.characterUIModel = CharacterUIModel(
			name: model.name,
			image: model.image,
			species: model.species,
			gender: model.gender?.rawValue,
			location: model.location?.name,
			status: model.status?.rawValue)

		present(detailsViewController, animated: true)

	}
}
