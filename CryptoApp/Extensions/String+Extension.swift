//
//  String+Extension.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 27.01.2022.
//

import Foundation

extension String {
    var localized: String { NSLocalizedString(self, comment: "") }
    
    var dollarRounded: String {
        return "$\(Double(self)?.rounded(toPlaces: 2) ?? 0)"
    }
    
    
}
