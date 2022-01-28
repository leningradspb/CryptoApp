//
//  SettingsViewController.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 28.01.2022.
//

import UIKit

final class SettingsViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI() {
        view.backgroundColor = .cryptoNavigationGrey
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .cryptoNavigationGrey
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//        tableView.separatorInset.left = 90
//        tableView.delegate = self
//        tableView.dataSource = self

        tableView.showsVerticalScrollIndicator = false
    }

    private func setupNavigationBar() {
        //        guard let navBar = navigationController?.navigationBar else { return }
        navigationItem.title = LocalizationNames.settings
        navigationItem.largeTitleDisplayMode = .always
    }

}
