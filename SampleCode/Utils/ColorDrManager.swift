//
//  ColorScheme.swift
//  SampleCode
//
//  Created by  KenNguyen on 04/06/2021.
//

import UIKit

enum ColorDr {
    
    case blue
    case blue_30_alpha
    case green
    case green_10_alpha
    case gray_text
    case black_text
    case red_text
    case gray_bg
    case white_text
    case custom(hexString: String, alpha: Double = 1.0)
    func withAlpha(_ alpha: Double) -> UIColor {
        return self.value.withAlphaComponent(CGFloat(alpha))
    }
    
}

extension ColorDr {
    
    var value: UIColor {
        var instanceColor = UIColor.clear
        switch self {
        case .blue:
            instanceColor = UIColor(named: "blue_color")!
        case .blue_30_alpha:
            instanceColor = UIColor(named: "blue_color_30_alpha")!
        case .green:
            instanceColor = UIColor(named: "green_bg")!
        case .green_10_alpha:
            instanceColor = UIColor(named: "green_bg_10_apha")!
        case .gray_text:
            instanceColor = UIColor(named: "gray_color_text")!
        case .black_text:
            instanceColor = UIColor(named: "black_color_text")!
        case .red_text:
            instanceColor = UIColor(named: "red_text")!
        case .gray_bg:
            instanceColor = UIColor(named: "gray_bg")!
        case .white_text:
            instanceColor = UIColor(named: "white_text")!

        case .custom(let hexValue, let opacity):
            instanceColor = UIColor(hexString: hexValue).withAlphaComponent(CGFloat(opacity))
        }
        return instanceColor
    }
    
}
