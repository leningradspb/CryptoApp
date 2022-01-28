//
//  HistoryModel.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 28.01.2022.
//

import Foundation

struct HistoryModel: Decodable {
    let data: [Asset]?
    struct Asset: Decodable {
        let priceUsd: String?
        let time: Double?
    }
}
