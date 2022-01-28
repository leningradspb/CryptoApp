//
//  AssetModel.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 28.01.2022.
//

import Foundation

struct AssetModel: Decodable {
    let data: [Asset]?
    struct Asset: Decodable {
        let id, symbol, name, rank, supply, maxSupply, marketCapUsd, volumeUsd24Hr, priceUsd, changePercent24Hr, vwap24Hr: String?
    }
}

