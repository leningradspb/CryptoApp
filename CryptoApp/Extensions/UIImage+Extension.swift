//
//  UIImage+Extension.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 28.01.2022.
//

import UIKit
import Nuke

extension UIImageView
{
    func setImageURL(path: String?, placeholder: UIImage? = nil)
    {
        if let path = path, let url = URL.init(string: path)
        {
//            self.af_setImage(withURL: url, placeholderImage: placeholder, imageTransition: .crossDissolve(0.2))
            
            let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.2))
            Nuke.loadImage(with: url, options: options, into: self)
        }
        else
        {
            self.image = placeholder
        }
    }
}
