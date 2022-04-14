//
//  UITextField+Extension.swift
//  SampleCode
//
//  Created by  KenNguyen on 05/07/2021.
//

import UIKit

extension UITextField {
    
    public func setFontName(fontName: FontDrName = .regular, fontSize: CGFloat = 14.0) {
        self.font = UIFont(name: fontName.rawValue, size: fontSize)
    }
    
    func setPlaceholderTextColor(color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: color])
    }

    func setPlaceholderFontName(fontName: FontDrName = .regular, fontSize: CGFloat = 14.0) {
        guard let font = UIFont(name: fontName.rawValue, size: fontSize) else { return }
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.font: font])
    }
    
}
