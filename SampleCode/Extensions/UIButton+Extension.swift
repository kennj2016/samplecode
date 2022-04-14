//
//  UIButton+Extension.swift
//  SampleCode
//
//  Created by  KenNguyen on 05/07/2021.
//

import UIKit

extension UIButton {
    
    func setUnderLine(for state: UIControl.State) {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(
            string: self.titleLabel?.text ?? "",
            attributes: attributes
        )
        
        self.setAttributedTitle(attributeString, for: state)
    }
    
}
