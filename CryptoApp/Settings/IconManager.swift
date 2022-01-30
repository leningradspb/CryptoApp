//
//  IconManager.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 30.01.2022.
//

import UIKit

final class IconManager {
    enum AppIcon: CaseIterable {
        
        case whiteIcon, blackIcon, yellowIcon
        
        var name: String? {
            switch self {
            case .whiteIcon:
                return "whiteIcon"
            case .blackIcon:
                return "blackIcon"
            case .yellowIcon:
                return "yellowIcon"
            }
        }
    }

    //check current icon
    static var current: AppIcon {
        return AppIcon.allCases.first(where: {$0.name == UIApplication.shared.alternateIconName}) ?? .whiteIcon
    }

    //set new icon
    static func setIcon(_ appIcon: AppIcon, completion: ((Bool) -> Void)? = nil) {
        guard current != appIcon, UIApplication.shared.supportsAlternateIcons
        else { return }
        
        UIApplication.shared.setAlternateIconName(appIcon.name) { error in
            if let error = error {
                print("Error setting the alternate icon \(appIcon.name ?? ""): \(error.localizedDescription)")
            }
            completion?(error != nil)
        }
    }
}

