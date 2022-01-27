//
//  ViewController.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 27.01.2022.
//

import UIKit

final class AssetsViewController: UIViewController {
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        //        guard let navBar = navigationController?.navigationBar else { return }
        navigationItem.title = LocalizationNames.assets
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
    }


}

