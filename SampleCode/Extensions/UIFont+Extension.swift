//
//  UIFont+Extension.swift
//  SampleCode
//
//  Created by  KenNguyen on 20/06/2021.
//

import UIKit

public enum FontDrName: String {
    case regular = "HelveticaNeue"
    case bold = "HelveticaNeue-Bold"
    case italic = "HelveticaNeue-Italic"
    case bold_italic = "HelveticaNeue-BoldItalic"
    case medium = "HelveticaNeue-Medium"
    case medium_italic = "HelveticaNeue-MediumItalic"

}

extension UIFontDescriptor.AttributeName {
    
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
    
}

extension UIFont {
    
    static var isOverrided: Bool = false
    
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: FontDrName.regular.rawValue, size: size)!
    }
    
    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: FontDrName.bold.rawValue, size: size)!
    }
    
    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: FontDrName.italic.rawValue, size: size)!
    }
    
    @objc class func myBoldItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: FontDrName.bold_italic.rawValue, size: size)!
    }
    
    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
            self.init(myCoder: aDecoder)
            return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = FontDrName.regular.rawValue
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = FontDrName.bold.rawValue
        case "CTFontObliqueUsage":
            fontName = FontDrName.italic.rawValue
        default:
            fontName = FontDrName.regular.rawValue
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }
    
    class func overrideInitialize() {
        guard self == UIFont.self, !isOverrided else { return }
        
        // Avoid method swizzling run twice and revert to original initialize function
        isOverrided = true
        
        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
           let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }
        
        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
           let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }
        
        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
           let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
        }
        
        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
           let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
    
}
