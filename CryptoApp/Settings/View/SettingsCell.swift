//
//  SettingsCell.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 28.01.2022.
//

import UIKit

final class SettingsCell: UITableViewCell {
    private let infoView = InfoView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(blackText: String, greyText: String) {
        infoView.blackText = blackText
        infoView.greyText = greyText
    }
    
    private func setupUI() {
        backgroundColor = .white
        contentView.backgroundColor = .white
        selectionStyle = .none
        contentView.addSubview(infoView)
        
        infoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    final class InfoView: UIView {
        private let black = CustomLabel(color: .black, font: .systemFont(ofSize: 17))
        private let grey = CustomLabel(color: .secondaryGrey.withAlphaComponent(0.6), font: .systemFont(ofSize: 17))
        private let arrowImageView = UIImageView(image: UIImage(named: "arrow"))
        
        var blackText: String? {
            didSet {
                black.text = blackText
            }
        }
        
        var greyText: String? {
            didSet {
                grey.text = greyText
            }
        }
        
        init() {
            super.init(frame: .zero)
            
            addSubviews([black, grey, arrowImageView])
            
            grey.textAlignment = .right
            
            grey.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            
            black.snp.makeConstraints {
                $0.top.equalToSuperview().offset(10)
                $0.leading.equalToSuperview().offset(16)
                $0.bottom.equalToSuperview().offset(-10)
            }
            
            grey.snp.makeConstraints {
                $0.top.equalToSuperview().offset(10)
                $0.leading.equalTo(black.snp.trailing).offset(6)
                $0.bottom.equalToSuperview().offset(-10)
            }
            
            arrowImageView.clipsToBounds = true
            arrowImageView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(grey.snp.trailing).offset(13)
                $0.trailing.equalToSuperview().offset(-13)
                $0.width.equalTo(9)
                $0.height.equalTo(14)
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
   
}
