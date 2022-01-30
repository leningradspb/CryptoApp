//
//  DetailSettingsCell.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 28.01.2022.
//

import UIKit

final class DetailSettingsCell: UITableViewCell {
    private let infoView = InfoView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(blackText: String, isNeededArrow: Bool) {
        infoView.blackText = blackText
        infoView.isNeededArrow = isNeededArrow
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
        private let arrowImageView = UIImageView(image: UIImage(named: "checkmark"))
        
        var isNeededArrow: Bool = true {
            didSet {
                arrowImageView.isHidden = !isNeededArrow
            }
        }
        
        var blackText: String? {
            didSet {
                black.text = blackText
            }
        }
        
        init() {
            super.init(frame: .zero)
            
            addSubviews([black, arrowImageView])
            
            black.snp.makeConstraints {
                $0.top.equalToSuperview().offset(10)
                $0.leading.equalToSuperview().offset(16)
                $0.bottom.equalToSuperview().offset(-10)
            }
            
            arrowImageView.clipsToBounds = true
            arrowImageView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(black.snp.trailing).offset(6)
                $0.trailing.equalToSuperview().offset(-13)
                $0.width.equalTo(15)
                $0.height.equalTo(15)
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
