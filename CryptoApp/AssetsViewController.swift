//
//  ViewController.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 27.01.2022.
//

import UIKit

final class AssetsViewController: UIViewController {

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
//        self.navigationController?.navigationBar.backgroundColor = .white
        
//        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
//
//        statusBar.backgroundColor = .blue
//        navigationController?.navigationBar.isTranslucent = false
       
    }


}

