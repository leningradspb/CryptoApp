//
//  WatchListViewController.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 28.01.2022.
//

import UIKit

final class WatchListViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    private func setupNavigationBar() {
        navigationItem.title = LocalizationNames.watchlist
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
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
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(AssetCell.self, forCellReuseIdentifier: AssetCell.identifier)
    }

}
extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WatchListAssets.assets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AssetCell.identifier, for: indexPath) as! AssetCell
        if indexPath.row < WatchListAssets.assets.count {
            let asset = WatchListAssets.assets[indexPath.row]
            cell.update(with: asset)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < WatchListAssets.assets.count {
            let asset = WatchListAssets.assets[indexPath.row]
            let vc = DetailAssetViewController(asset: asset)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
