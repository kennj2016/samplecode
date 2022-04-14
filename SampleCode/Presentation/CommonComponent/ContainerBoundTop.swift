//
//  ContainerBoundTop.swift
//  sample
//
//  Created by KenNguyen 10/10/2021.
//

import UIKit

class ContainerBoundTop: UIView {
    // MARK: System
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners([.topLeft,.topRight], radius: 50)

    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}
