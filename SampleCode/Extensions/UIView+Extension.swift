//
//  UIView+Extension.swift
//  SampleCode
//
//  Created by  KenNguyen on 21/06/2021.
//

import UIKit

extension UIView {
    
    func setHorizontalGradientColor(startColor: UIColor, endColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        var updatedFrame = self.bounds
        updatedFrame.size.height += 20
        gradientLayer.frame = updatedFrame
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
}
