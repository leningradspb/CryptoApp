//
//  AssetCell.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 28.01.2022.
//

import UIKit

final class AssetCell: UITableViewCell {
    private let assetImageView = UIImageView()
    private let symbolLabel = CustomLabel(color: .black, font: .systemFont(ofSize: 22))
    private let usdPriceLabel = CustomLabel(color: .secondaryGrey.withAlphaComponent(0.6), font: .systemFont(ofSize: 22))
    private let nameLabel = CustomLabel(color: .cryptoGrey.withAlphaComponent(0.6), font: .systemFont(ofSize: 13))
    private let changePercent24HrLabel = PercentageLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: AssetModel.Asset) {
        symbolLabel.text = model.symbol
        nameLabel.text = model.name
        usdPriceLabel.text = model.priceUsd?.dollarRounded
        changePercent24HrLabel.percentageText = model.changePercent24Hr?.rounded
    }
    
    private func setupUI() {
        backgroundColor = .white
        contentView.backgroundColor = .white
        selectionStyle = .none
        contentView.addSubviews([assetImageView, symbolLabel, usdPriceLabel, nameLabel, changePercent24HrLabel])
        
        assetImageView.layer.cornerRadius = 30
        assetImageView.clipsToBounds = true
        assetImageView.backgroundColor = .blue
        
        assetImageView.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.leading.equalToSuperview().offset(15)
            $0.centerY.equalToSuperview()
        }
        
        symbolLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.leading.equalTo(assetImageView.snp.trailing).offset(15)
        }
        
        usdPriceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        usdPriceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(symbolLabel.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(symbolLabel.snp.bottom).offset(4)
            $0.leading.equalTo(assetImageView.snp.trailing).offset(15)
//            $0.trailing.equalToSuperview().offset(-15)
        }
        
        changePercent24HrLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        changePercent24HrLabel.snp.makeConstraints {
            $0.top.equalTo(usdPriceLabel.snp.bottom).offset(7)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().offset(-15)
        }
    }
    
   
}
