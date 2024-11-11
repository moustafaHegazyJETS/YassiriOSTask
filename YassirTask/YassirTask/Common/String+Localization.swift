//
//  String+Localization.swift
//  YassirTask
//
//  Created by Moustafa Hegazy on 11/11/2024.
//

import Foundation

extension String {
	func localized()-> String {
		return NSLocalizedString(
			self,
			tableName: "Localizable",
			bundle: .main,
			value: self,
			comment: self)
	}
}
