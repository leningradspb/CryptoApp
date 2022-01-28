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
    let xs: [CGFloat] = [5, 10, 15]
    private var prevX: CGFloat = 0
    private var prevY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(chartView)
        view.backgroundColor = .blue
        chartView.backgroundColor = .green
        chartView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(130)
        }
        for i in 0..<xs.count {
//                    let topPoint = CGPoint(x: view.frame.midX - 50, y: view.bounds.minY)
//                    let bottomPoint = CGPoint(x: view.frame.midX, y: view.bounds.maxY)
            let topPoint = CGPoint(x: xs[i], y: 0)
            
            let bottomPoint = CGPoint(x: (view.frame.width / CGFloat(xs.count)) * (CGFloat(i) + CGFloat(1)) , y: 0)
            let strokeLength = Int(view.frame.width) / xs.count
            print(view.frame.width, strokeLength)
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
