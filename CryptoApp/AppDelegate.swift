//
//  AppDelegate.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 27.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let tabBar = TabBarVC()
        self.window?.rootViewController = tabBar
        self.window?.makeKeyAndVisible()
        
//        if #available(iOS 13.0, *) {
//            let tabBarAppearance = UITabBarAppearance()
//            tabBarAppearance.configureWithTransparentBackground()
//            tabBarAppearance.backgroundColor = UIColor.white
//
//            tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.systemGray
//            tabBarAppearance.stackedLayoutAppearance.selected.iconColor =  .cryptoBlue
//            // #1E792C
//            UITabBar.appearance().standardAppearance = tabBarAppearance
//            if #available(iOS 15.0, *) {
//                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
//            }
//        } else {
            UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().tintColor = .cryptoBlue
//        UITabBar.appearance().barTintColor = .cryptoBlue
//        }
      
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

