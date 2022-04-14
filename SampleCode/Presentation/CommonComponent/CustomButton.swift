//
//  CustomButton.swift
//  sample
//
//  Created by KenNguyen 12/10/2021.
//

import UIKit
import SwiftUI

class CustomButton: UIButton {
    // MARK: System
    private var isAtributted = false
    private var isButtonNormal = false
    private var isButtonLine = false

    var isValidButton = false {
        didSet {
            self.backgroundColor = isValidButton ? ColorDr.blue.value : ColorDr.blue.withAlpha(0.3)
            self.isEnabled = isValidButton
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if isButtonLine {
            self.layer.cornerRadius = self.frame.height/2
            self.clipsToBounds = true
            return
        }
        
        if isButtonNormal {
            return
        }
        if isAtributted == false {
            self.titleLabel?.setFontName()
            self.layer.cornerRadius = self.frame.height/2
            self.clipsToBounds = true
            self.backgroundColor = isValidButton ? ColorDr.blue.value : ColorDr.blue.withAlpha(0.3)

        }
    }
    
    func setTitleButtonLine(string: String, color: UIColor, backgroundColor: UIColor?) {
        self.isButtonLine = true
        self.titleLabel?.setFontName()
        self.setTitleColor(color, for: .normal)
        self.backgroundColor = .clear
        self.setTitle(string, for: .normal)
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
            self.setTitleColor(.white, for: .normal)
        }
    }
    
    
    func setTitle(nomarlString: String, titleColor: UIColor) {
        self.isButtonNormal = true
        self.titleLabel?.setFontName()
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = .clear
        self.setTitle(nomarlString, for: .normal)
    }

    func setAtrributeString(nomarlString: String,highlightString: String, _ bg_color: UIColor? = .clear) {
        self.isAtributted = true
        self.backgroundColor = bg_color

        let full = "\(nomarlString) \(highlightString)"
        let attribute = NSMutableAttributedString(string: full)
        attribute.addFont(string: full, font: UIFont(name: FontDrName.regular.rawValue, size: 14)!)
        attribute.addColor(string: nomarlString, color: ColorDr.gray_text.value)
        attribute.addColor(string: highlightString, color: ColorDr.blue.value)
        self.setAttributedTitle(attribute, for: .normal)
    }

}
