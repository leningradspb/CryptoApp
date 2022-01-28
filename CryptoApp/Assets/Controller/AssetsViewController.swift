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
    private let refreshControl = UIRefreshControl()
    private var assets: [AssetModel.Asset] = []
    private var offset: Int = 0
    private let offsetStep: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupNavigationBar()
        setupTableView()
        loadAssets()
//        ApiService.shared.getProfileStatus { profileStatus, error in
//            print("!!!!@!!@!@!@ \n\n\n", profileStatus, error)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupNavigationBar() {
        //        guard let navBar = navigationController?.navigationBar else { return }
        navigationItem.title = LocalizationNames.assets
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
        refreshControl.tintColor = .gray
        tableView.refreshControl = refreshControl
        tableView.showsVerticalScrollIndicator = false
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        
        tableView.register(AssetCell.self, forCellReuseIdentifier: AssetCell.identifier)
    }
    
    private func loadAssets() {
        let request = CustomRequest("assets/?limit=10", params: ["offset": offset])
        APIManager.shared.makeRequest(request, responseType: AssetModel.self) { [weak self] result in
//            print(result)
            self?.refreshControl.endRefreshing()
            guard let self = self, let assets = result.data else { return }
//            if assets.isEmpty {
//                self.assets = assets
//            } else {
//                self.assets += assets
//            }
            self.assets += assets
            
            self.tableView.reloadData()
        } failure: { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
    
    @objc private func onRefresh() {
        offset = 0
        assets.removeAll()
        loadAssets()
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
            cell.update(with: asset)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < assets.count {
            let asset = assets[indexPath.row]
            let vc = DetailAssetViewController(asset: asset)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !assets.isEmpty, indexPath.row == assets.count - 1 {
            offset += offsetStep
            loadAssets()
        }
    }
}
