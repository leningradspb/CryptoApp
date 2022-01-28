//
//  UIColor+Extension.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 27.01.2022.
//

import UIKit

extension UIColor {
    /// #007AFF
    static let cryptoBlue = UIColor(hexString: "#007AFF")
    
    static let cryptoNavigationGrey = UIColor(hexString: "#F2F2F2")
    
    /// #3C3C43
    static let secondaryGrey = UIColor(hexString: "#3C3C43")
    
    /// #8E8E93
    static let cryptoGrey = UIColor(hexString: "#8E8E93")
    
    /// #FF3B30
    static let cryptoRed = UIColor(hexString: "#FF3B30")
    
    /// #34C759
    static let cryptoGreen = UIColor(hexString: "#34C759")
}

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
