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
        
        tableView.separatorInset.left = 16
        tableView.delegate = self
        tableView.dataSource = self

        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
    }

    private func setupNavigationBar() {
        //        guard let navBar = navigationController?.navigationBar else { return }
        navigationItem.title = LocalizationNames.settings
        navigationItem.largeTitleDisplayMode = .always
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier, for: indexPath) as! SettingsCell
        cell.update(blackText: "Icon", greyText: "Black")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
}
