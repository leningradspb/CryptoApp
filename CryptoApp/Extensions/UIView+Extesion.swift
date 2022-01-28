//
//  UIView+Extesion.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 28.01.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { self.addSubview($0) }
    }
}

extension UIStackView {
    func addArranged(subviews:[UIView]) {
        subviews.forEach { self.addArrangedSubview($0) }
    }
}
