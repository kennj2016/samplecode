//
//  UILabel+Extension.swift
//  SampleCode
//
//  Created by  KenNguyen on 13/06/2021.
//

import UIKit

extension UILabel{
    
    public func setFontName(fontName: FontDrName = .regular, fontSize: CGFloat = 14.0) {
        self.font = UIFont(name: fontName.rawValue, size: fontSize)
    }
    
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    func addCharacterSpacing(kernValue: Double = 1.15) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
    
    private func createParagrapthStyle(lineSpacing: CGFloat = 0.0) -> NSMutableParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineSpacing
        paragraphStyle.maximumLineHeight = lineSpacing
        paragraphStyle.alignment = self.textAlignment
        
        return paragraphStyle
    }
    
    func setSpannedColor (fullText : String, changeText : String, changeTextColor: UIColor, changeTextFont: UIFont?, lineSpacing: CGFloat = 0.0) {
        let strNumber: NSString = fullText.uppercased() as NSString
        let range = (strNumber).range(of: changeText.uppercased())
        let attribute = NSMutableAttributedString.init(string: fullText)
        
        if let font = changeTextFont {
            attribute.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        }
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: changeTextColor, range: range)
        attribute.addAttribute(NSAttributedString.Key.paragraphStyle, value: createParagrapthStyle(lineSpacing: lineSpacing), range: NSRange(location: 0, length: attribute.length))
        
        
        self.attributedText = attribute
    }
    
    func setLineSpacing(lineSpacing: CGFloat) {
        guard let finalText = text else { return }
        let attribute = NSMutableAttributedString(string: finalText)
        let range = NSRange(location: 0, length: attribute.length)
        if let finalFont = font {
            attribute.addAttribute(NSAttributedString.Key.font, value: finalFont, range: range)
        }
        if let finalTextColor = textColor {
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: finalTextColor, range: range)
        }
        attribute.addAttribute(NSAttributedString.Key.paragraphStyle, value: createParagrapthStyle(lineSpacing: lineSpacing), range: NSRange(location: 0, length: attribute.length))
        attributedText = attribute
    }
    
}
