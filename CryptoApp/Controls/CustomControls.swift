//
//  CustomControls.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 28.01.2022.
//

import UIKit

final class CustomLabel: UILabel {

    init(color: UIColor, font: UIFont) {
        super.init(frame: .zero)
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.font = font
        self.textColor = color
    }

    init(color: UIColor, font: UIFont, numberOfLines: Int, lineBreakMode: NSLineBreakMode) {
        super.init(frame: .zero)
        self.numberOfLines = numberOfLines
        self.lineBreakMode = lineBreakMode
        self.font = font
        self.textColor = color
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
