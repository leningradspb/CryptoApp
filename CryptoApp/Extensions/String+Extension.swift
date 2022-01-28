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
        return "$\(self.rounded)"
    }
    
    var rounded: String {
        return "\(Double(self)?.rounded(toPlaces: 2) ?? 0)"
    }
    
}

extension Optional where Wrapped == String
{
    var orEmpty: String
    {
        switch self {
        case .none:
            return ""
        case .some(let wrapped):
            return wrapped
        }
    }
}
extension String
{
    func replace(string:String, replacement:String) -> String
    {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
}
