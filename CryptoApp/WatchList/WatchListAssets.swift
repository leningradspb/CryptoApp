//
//  WatchListAssets.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 28.01.2022.
//

import Foundation

final class WatchListAssets {
    static var assets: [AssetModel.Asset] {
//        UserDefaults.standard.object(forKey: "Assets") as! [AssetModel.Asset]
        if let data = UserDefaults.standard.data(forKey: "Assets") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let asset = try decoder.decode([AssetModel.Asset].self, from: data)
                return asset
            } catch {
                print("Unable to Decode Note (\(error))")
                return []
            }
        } else {
            return []
        }
    }
}
