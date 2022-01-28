//
//  ViewController.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 27.01.2022.
//

import UIKit
import SnapKit

final class AssetsViewController: UIViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var assets: [AssetModel.Asset] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupNavigationBar()
        setupTableView()
        let request = CustomRequest("assets/?limit=10", params: ["offset":0])
        APIManager.shared.makeRequest(request, responseType: AssetModel.self) { [weak self] result in
            print(result)
            guard let self = self, let assets = result.data else { return }
            self.assets = assets
            self.tableView.reloadData()
        }
//        ApiService.shared.getProfileStatus { profileStatus, error in
//            print("!!!!@!!@!@!@ \n\n\n", profileStatus, error)
//        }
    }
    
    private func setupNavigationBar() {
        //        guard let navBar = navigationController?.navigationBar else { return }
        navigationItem.title = LocalizationNames.assets
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.separatorInset.left = 90
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AssetCell.self, forCellReuseIdentifier: AssetCell.identifier)
    }


}

extension AssetsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AssetCell.identifier, for: indexPath) as! AssetCell
        if indexPath.row < assets.count {
            let asset = assets[indexPath.row]
            cell.update(with: asset )
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80.5
    }
}
