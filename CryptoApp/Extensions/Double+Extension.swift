//
//  Double+Extension.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 28.01.2022.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var stringWithAddedPlusIfRequired: String {
        return self > 0 ? "+\(self.stringWithoutTrailingZeros)" : "\(self.stringWithoutTrailingZeros)"
    }
    
    var stringWithoutTrailingZeros: String {
        return String(format: "%g", self)
    }
}
    
 

