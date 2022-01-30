//
//  DetailSettingsViewController.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 28.01.2022.
//

import UIKit

final class DetailSettingsViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let icons = [LocalizationNames.white, LocalizationNames.black, LocalizationNames.yellow]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        tableView.register(DetailSettingsCell.self, forCellReuseIdentifier: DetailSettingsCell.identifier)
    }

    private func setupNavigationBar() {
        //        guard let navBar = navigationController?.navigationBar else { return }
        navigationItem.title = LocalizationNames.icon
//        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = false
    }

}

extension DetailSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        icons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailSettingsCell.identifier, for: indexPath) as! DetailSettingsCell
        cell.update(blackText: LocalizationNames.icon, greyText: LocalizationNames.black)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var appIcon = "whiteIcon"
        
        switch icons[indexPath.row] {
        case LocalizationNames.white:
            IconManager.setIcon(.whiteIcon) { isSuccess in
                print("isSuccess = \(isSuccess)")
            }
//            appIcon = "whiteIcon"
        case LocalizationNames.black:
            IconManager.setIcon(.blackIcon) { isSuccess in
                print("isSuccess = \(isSuccess)")
            }
//            appIcon = "blackIcon"
        case LocalizationNames.yellow:
            IconManager.setIcon(.yellowIcon) { isSuccess in
                print("isSuccess = \(isSuccess)")
            }
//            appIcon = "yellowIcon"
        default:
            break
        }
        
        
//        UIApplication.shared.setAlternateIconName(appIcon) { error in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                print("Success!")
//            }
//        }
    }
}

