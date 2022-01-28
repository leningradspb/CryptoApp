//
//  DetailAssetViewController.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 28.01.2022.
//

import UIKit

final class DetailAssetViewController: UIViewController {
    private let usdPriceLabel = CustomLabel(color: .secondaryGrey.withAlphaComponent(0.6), font: .systemFont(ofSize: 64, weight: .thin))
    private let changePercent24HrLabel = PercentageLabel()
    private let chartView = UIView()
    private let heartButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    let price = [7672, 8058, 8232, 6987]
    let values: [CGFloat] = [10, 8, 2, 20]
    private var prevX: CGFloat = 0
    private var prevY: CGFloat = 0
    private let constantChartViewHeight: CGFloat = 130
    
    private var isInWatchList: Bool {
        WatchListAssets.assets.contains(where: {$0.id == asset.id})
    }
//    private var history: [HistoryModel.Asset] = []
    
    private let asset: AssetModel.Asset
    init(asset: AssetModel.Asset) {
        self.asset = asset
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadHistory()
    }
    
    private func setupUI() {
        navigationItem.title = asset.name.orEmpty + " " + asset.symbol.orEmpty
        navigationController?.navigationBar.prefersLargeTitles = false
        
        heartButton.isSelected = isInWatchList
        heartButton.addTarget(self, action: #selector(watchListTapped), for: .touchUpInside)
        heartButton.setImage(UIImage(named: "heart"), for: .normal)
        heartButton.setImage(UIImage(named: "heart.fill"), for: .selected)
        let rightButton = UIBarButtonItem(customView: heartButton)
        
        navigationItem.rightBarButtonItem = rightButton
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: isInWatchList ? "heart.fill" : "heart"),
//                                                               style: .plain,
//                                                               target: self,
//                                                               action: #selector(watchListTapped))
        let topSeparator = createSeparator()
        let short1Separator = createSeparator()
        let short2Separator = createSeparator()
        let bottomSeparator = createSeparator()
        let marketCap = DetailAssetInfoView(blackText: "Market Cap", greyText: asset.marketCapUsd)
        let supply = DetailAssetInfoView(blackText: "Supply", greyText: asset.supply)
        let volume = DetailAssetInfoView(blackText: "Volume (24h)", greyText: asset.volumeUsd24Hr)
        
        view.addSubviews([usdPriceLabel, changePercent24HrLabel, chartView, topSeparator, marketCap, short1Separator, supply, short2Separator, volume, bottomSeparator])
        view.backgroundColor = UIColor(hexString: "#F9F9F9")
        
        usdPriceLabel.text = asset.priceUsd?.dollarRounded
        usdPriceLabel.textAlignment = .center
        
        usdPriceLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
        }
        
        changePercent24HrLabel.percentageText = asset.changePercent24Hr?.rounded
        changePercent24HrLabel.textAlignment = .center
        changePercent24HrLabel.font = .systemFont(ofSize: 22)
        
        changePercent24HrLabel.snp.makeConstraints {
            $0.top.equalTo(usdPriceLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
        }
        
        chartView.backgroundColor = UIColor(hexString: "#F9F9F9")
        chartView.snp.makeConstraints {
            $0.top.equalTo(changePercent24HrLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(constantChartViewHeight)
        }
        
        topSeparator.snp.makeConstraints {
            $0.top.equalTo(chartView.snp.bottom).offset(28)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        marketCap.snp.makeConstraints {
            $0.top.equalTo(topSeparator.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        short1Separator.snp.makeConstraints {
            $0.top.equalTo(marketCap.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview()
        }
        
        supply.snp.makeConstraints {
            $0.top.equalTo(short1Separator.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        short2Separator.snp.makeConstraints {
            $0.top.equalTo(supply.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview()
        }
        
        volume.snp.makeConstraints {
            $0.top.equalTo(short2Separator.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        bottomSeparator.snp.makeConstraints {
            $0.top.equalTo(volume.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    

    private func loadHistory() {
        guard let id = asset.id else {return}
//        let params = ["start": 1643287400]
        let request = CustomRequest("assets/\(id)/history?interval=m5")
        APIManager.shared.makeRequest(request, responseType: HistoryModel.self) { [weak self]  response in
            guard let self = self else { return }
            print(response.data)
            if let history = response.data {
                var floatHistory: [CGFloat] = []
                history.forEach {
                    if let double = Double($0.priceUsd.orEmpty) {
                        floatHistory.append(CGFloat(double))
                    }
                }
                print(floatHistory)
                self.createChart(values: floatHistory)
//                self.history = history
            }
        } failure: {
            print("FAIL")
        }

    }
    
    
    private func createChart(values: [CGFloat]) {
        let minValue = values.min()!
        let maxValue = values.max()!
        
        for i in 0..<values.count {
            let value = values[i]
            let isFirst = i == 0
            let isMinValue = value == minValue

            let multiplier = constantChartViewHeight / maxValue
            
            var y: CGFloat
            if isMinValue {
                y = 130
            }  else {
                y = (constantChartViewHeight - (multiplier * value))
            }

            let topPoint = CGPoint(x: prevX, y: prevY)
            prevY = y

            let bottomPoint = CGPoint(x: (view.frame.width / CGFloat(values.count - 1)) * (CGFloat(i)) , y: y)

            let strokeLength = isFirst ? 0: Int(view.frame.width) / (values.count - 1)
            print(view.frame.width, strokeLength)
            prevX += CGFloat(strokeLength)
            chartView.createDashedLine(from: topPoint, to: bottomPoint, color: .black, strokeLength: NSNumber(integerLiteral: strokeLength), gapLength: 0, width: 2)
        }
    }
    
    private func createSeparator() -> UIView {
        let v = UIView()
        v.snp.makeConstraints { $0.height.equalTo(1) }
        v.backgroundColor = UIColor(hexString: "#C6C6C8")
        return v
    }
    
    @objc private func watchListTapped() {
        var assets = WatchListAssets.assets
        
        if isInWatchList {
            assets.removeAll(where: {$0.id == asset.id})
        } else {
            assets.append(asset)
        }
        
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(assets)

            // Write/Set Data
            heartButton.isSelected = !heartButton.isSelected
            UserDefaults.standard.set(data, forKey: "Assets")

        } catch {
            print("Unable to Encode Note (\(error))")
        }
        
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: isInWatchList ? "heart.fill" : "heart"),
//                                                               style: .plain,
//                                                               target: self,
//                                                               action: #selector(watchListTapped))
//        UserDefaults.standard.set(assets, forKey: "Assets")
    }
    

}

extension UIView {

    func createDashedLine(from point1: CGPoint, to point2: CGPoint, color: UIColor, strokeLength: NSNumber, gapLength: NSNumber, width: CGFloat) {
        let shapeLayer = CAShapeLayer()

        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = [strokeLength, gapLength]

        let path = CGMutablePath()
        path.addLines(between: [point1, point2])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}
