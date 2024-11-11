//
//  CharacterDetailsViewController.swift
//  YassirTask
//
//  Created by Moustafa Hegazy on 11/11/2024.
//

import UIKit

class CharacterDetailsViewController: UIViewController {

	@IBOutlet weak var characterImageView: UIImageView!
	@IBOutlet weak var backButton: UIButton!
	@IBOutlet weak var characterName: UILabel!
	@IBOutlet weak var characterStatusLabel: UILabel!
	@IBOutlet weak var characterSpeciesLabel: UILabel!
	@IBOutlet weak var characterGenderLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var characterLocationLabel: UILabel!
	@IBOutlet weak var statusBackgroundView: UIView!

	var characterUIModel: CharacterUIModel?

	let preferredCornerRadius = 15.0


	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupData()
	}

	func setupUI() {
		backButton.layer.cornerRadius = backButton.frame.width / 2
		characterImageView.layer.cornerRadius = preferredCornerRadius
		statusBackgroundView.layer.cornerRadius = preferredCornerRadius

		backButton.accessibilityIdentifier = "CharacterDetailsBackButton"
		characterStatusLabel.accessibilityIdentifier = "CharacterStatusLabel"
		characterName.accessibilityIdentifier = "CharacterNameLabel"
	}

	func setupData() {
		setupImageView(url: characterUIModel?.image ?? "")
		characterName.text = characterUIModel?.name
		characterSpeciesLabel.text = characterUIModel?.species
		characterGenderLabel.text = characterUIModel?.gender
		characterLocationLabel.text = characterUIModel?.location
		characterStatusLabel.text = characterUIModel?.status

		locationLabel.text = "Location".localized()

	}

	func setupImageView(url: String) {
		let url = URL(string: url)

		guard let url = url else { return }
		DispatchQueue.global().async {
			if let data = try? Data(contentsOf: url) {
				DispatchQueue.main.async {
					self.characterImageView.image = UIImage(data: data)
				}
			}
		}

	}


	@IBAction func backButtonDidPressed(_ sender: Any) {
		dismiss(animated: true)
	}
}
