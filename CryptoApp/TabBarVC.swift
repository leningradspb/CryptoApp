//
//  TabBarVC.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 27.01.2022.
//

import UIKit

final class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        var tabBarList: [UIViewController]!
        
        let assetsNC = UINavigationController()
        let assetsVC = AssetsViewController()
        assetsNC.viewControllers = [assetsVC]
        
        let bubbleIcon = UIImage(named: "bitcoinsign.circle.fill")
//        NSLocalizedString("Assets", comment: "")
        assetsVC.tabBarItem.title = LocalizationNames.assets
        assetsVC.tabBarItem.image = bubbleIcon
        assetsVC.tabBarItem.tag = 0
        
        tabBar.backgroundColor = .white
        tabBarList = [assetsNC]
        viewControllers = tabBarList
    }
}
