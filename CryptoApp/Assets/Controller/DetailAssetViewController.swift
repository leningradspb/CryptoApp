//
//  DetailAssetViewController.swift
//  CryptoApp
//
//  Created by Eduard Sinyakov on 28.01.2022.
//

import UIKit

class DetailAssetViewController: UIViewController {
    private let chartView = UIView()
    let price = [7672, 8058, 8232, 6987]
    let values: [CGFloat] = [10, 8, 2, 20]
    private var prevX: CGFloat = 0
    private var nextY: CGFloat = 0
    private let constantChartViewHeight: CGFloat = 130
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chartView)
        view.backgroundColor = .blue
        chartView.backgroundColor = .green
        chartView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(constantChartViewHeight)
        }
        
        let minValue = values.min()!
        let maxValue = values.max()!
        
        for i in 0..<values.count {
            let value = values[i]
            
            let multiplier = constantChartViewHeight / maxValue
            
//            var y: CGFloat = 0
//
//            if minValue == value {
//                y = 130
//            } else if maxValue == value {
//                y = 0
//            } else {
//                y = constantChartViewHeight - (multiplier * value)
//            }
            
            var y: CGFloat = i == 0 ? (constantChartViewHeight - (multiplier * value)) : nextY
            
            
//            nextY = i == values.count - 1 ? y : values[i + 1]
            
//            if i == 0 {
//                nextY = y
//            }
//                    let topPoint = CGPoint(x: view.frame.midX - 50, y: view.bounds.minY)
//                    let bottomPoint = CGPoint(x: view.frame.midX, y: view.bounds.maxY)
            let topPoint = CGPoint(x: prevX, y: y)
            nextY = i == 0 ? y : (constantChartViewHeight - (multiplier * values[i]))
//            nextY = (multiplier * values[i + 1])
            let bottomPoint = CGPoint(x: (view.frame.width / CGFloat(values.count)) * (CGFloat(i) + CGFloat(1)) , y: nextY)
//            prevY = y
            let strokeLength = Int(view.frame.width) / values.count
            print(view.frame.width, strokeLength)
            prevX += CGFloat(strokeLength)
            chartView.createDashedLine(from: topPoint, to: bottomPoint, color: .black, strokeLength: NSNumber(integerLiteral: strokeLength), gapLength: 0, width: 2)
        }
//        let topPoint = CGPoint(x: view.frame.midX, y: view.bounds.minY)
//        let bottomPoint = CGPoint(x: view.frame.midX, y: view.bounds.maxY)
//
//        view.createDashedLine(from: topPoint, to: bottomPoint, color: .black, strokeLength: 14, gapLength: 6, width: 2)
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
