//
//  ViewController.swift
//  YassirTask
//
//  Created by Moustafa Hegazy on 09/11/2024.
//

// register cell
// create cells for table and collection using swift ui
// show cells with dummy data
// handle loading

import UIKit
import SwiftUI

class CharactersViewController: UIViewController {
//	@IBOutlet weak var filterCollectionView: UICollectionView!
	@IBOutlet weak var charactersTableView: UITableView!
	@IBOutlet weak var filterStackView: UIStackView!


	let refreshControl = UIRefreshControl()
	let tableViewCellID = "CharactersCell"
	var viewModel: CharactersViewModel?
	var pageNumber = 0
	let filterArray = [
		Status.dead.rawValue.localized(),
		Status.alive.rawValue.localized(),
		Status.unknown.rawValue.localized()]

	// to be moved to viewmodel

	var lastSelectedFilterIndex: Int?

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupFilterStackView()
		setupRefreshController()
		registerScrollingCells()
	}

	func setupUI() {
		navigationController?.navigationBar.prefersLargeTitles = true
		self.title = "CharactersTitle".localized()

		charactersTableView.delegate = self
		charactersTableView.dataSource = self

		viewModel = CharactersViewModel()
		fetchData()
	}

	func setupFilterStackView() {
		for index in 0...2 {
			addSubViewToStack(index: index)
		}
		filterStackView.addArrangedSubview(UIView())

	}

	func addSubViewToStack(index: Int) {
		let filterView = FilterView(
			title: filterArray[index],
			filterationIndex: index,
			filterCallBack: { [weak self] selectedIndex in
				self?.makeFilter(index: selectedIndex)
			})

		let hostingController = UIHostingController(rootView: filterView)

		filterStackView.addArrangedSubview(hostingController.view)
	}

	func makeFilter(index: Int) {
		guard let filterIndex = lastSelectedFilterIndex else {
			viewModel?.applyFilter(index: index)
			charactersTableView.reloadData()
			lastSelectedFilterIndex = index
			setTitle(index: index)
			return
		}


		if filterIndex == index {
			lastSelectedFilterIndex = nil
			setTitle(index: lastSelectedFilterIndex)
			viewModel?.cancelFilter()
		} else {
			viewModel?.cancelFilter()
			viewModel?.applyFilter(index: index)

			setTitle(index: index)
			lastSelectedFilterIndex = index
		}



		charactersTableView.reloadData()
	}

	func setTitle(index: Int?) {
		guard let index = index else {
			self.title = "CharactersTitle".localized()
			return
		}

		switch index {
		case 0:
			self.title = "DeadChar".localized()
		case 1:
			self.title = "AliveChar".localized()
		case 2:
			self.title = "UnknownChar".localized()
		default:
			self.title = "CharactersTitle".localized()
		}

	}

	func setupRefreshController() {
		refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
		charactersTableView.refreshControl = refreshControl

	}

	@objc func fetchData() {
		Task {
			await viewModel?.getCharactersInPage(pageNumber: pageNumber)
			charactersTableView.reloadData()
		}
		pageNumber += 1
		refreshControl.endRefreshing()
	}

	func registerScrollingCells() {
		charactersTableView.register(UITableViewCell.self,
									 forCellReuseIdentifier: tableViewCellID)

	}


}

