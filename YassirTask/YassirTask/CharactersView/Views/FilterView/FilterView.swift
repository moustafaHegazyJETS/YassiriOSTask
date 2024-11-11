//
//  FilterView.swift
//  YassirTask
//
//  Created by Moustafa Hegazy on 10/11/2024.
//

import SwiftUI

struct FilterView: View {

	let title: String
	let filterationIndex: Int
	let filterCallBack: ((Int) -> ())

    var body: some View {

		Button {
			filterCallBack(filterationIndex)
		} label: {
			Text(title)
				.foregroundColor(.black)
				.padding()
				.overlay(
					RoundedRectangle(
						cornerRadius: 30)
						.stroke(.gray, lineWidth: 1)
				)
		}.accessibilityIdentifier("FilterCell_\(title)")

    }
}
