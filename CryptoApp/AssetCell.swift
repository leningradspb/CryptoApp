//
//  AssetCell.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 28.01.2022.
//

import UIKit

final class AssetCell: UITableViewCell {
    
    private let nameLabel = UILabel()
   
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.backgroundColor = .white
        selectionStyle = .none
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
//            $0.top
//            $0.leading
//            $0.trailing
//            $0.bottom
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(text: String) {
        nameLabel.text = text
    }
}
