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
        
        let watchListNC = UINavigationController()
        let watchListVC = WatchListViewController()
        watchListNC.viewControllers = [watchListVC]
        
        let heartIcon = UIImage(named: "heart.fill")
        watchListVC.tabBarItem.title = LocalizationNames.watchlist
        watchListVC.tabBarItem.image = heartIcon
        watchListVC.tabBarItem.tag = 1
        
        let settingsNC = UINavigationController()
        let settingsVC = SettingsViewController()
        settingsNC.viewControllers = [settingsVC]
        
        let settingIcon = UIImage(named: "gearshape.fill")
        settingsVC.tabBarItem.title = LocalizationNames.settings
        settingsVC.tabBarItem.image = settingIcon
        settingsVC.tabBarItem.tag = 2
        
        tabBar.backgroundColor = .white
        tabBarList = [assetsNC, watchListNC, settingsNC]
        viewControllers = tabBarList
    }
}
