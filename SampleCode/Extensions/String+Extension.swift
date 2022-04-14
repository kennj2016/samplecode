//
//  StringExtension.swift
//  SampleCode
//
//  Created by  KenNguyen on 08/06/2021.
//

import Foundation
import UIKit

extension String {
    
    func localized() -> String {
        if LanguageManager.shared.currentLanguage == .en {
            return self
        }
        guard let plistData = PListManager.shared.readPropertyList() else { return self }
        guard let localizationValue = plistData[self] as? String else { return self }
        return localizationValue
    }
    
}
extension NSMutableAttributedString {
    
    public func color(string : String, color : UIColor)  -> Self {
        let attributedString = NSAttributedString.init(string: string, attributes: [NSAttributedString.Key.foregroundColor : color])
        self.append(attributedString)
        return self
    }
    
    public func backgroundColorColor(string : String, color : UIColor)  -> Self {
        let attributedString = NSAttributedString.init(string: string, attributes: [NSAttributedString.Key.backgroundColor : color])
        self.append(attributedString)
        return self
    }
    
    func addFont(string : String, font : UIFont){
        
        let currentString = NSString.init(string: self.string)
        self.addAttribute(NSAttributedString.Key.font, value: font, range: currentString.range(of: string))
    }
    
    func addColor(string : String, color : UIColor){
        let currentString = NSString.init(string: self.string)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: currentString.range(of: string))
    }
    
    func addBackgroundColor(string : String, color : UIColor){
        let currentString = NSString.init(string: self.string)
        self.addAttribute(NSAttributedString.Key.backgroundColor, value: color, range: currentString.range(of: string))
    }
    
    func addUnderline(string : String){
        let currentString = NSString.init(string: self.string)
        self.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: currentString.range(of: string))
    }
    func addStrikethroughStyle(string : String){
        let currentString = NSString.init(string: self.string)
        self.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: currentString.range(of: string))
    }
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension String  {
    //Date
    func dateToString(_ formatSever: [DateFormat], utcOffset:Int ,_ formatApp: String? = "") -> String {
        var sourceDate: Date?
        for item in formatSever {
            if let date = getDateFromFormat(item.rawValue, utcOffset: utcOffset) {
                sourceDate = date
                break
            }
        }
        guard let dateAPI = sourceDate else {
            return self
        }
        return dateAPI.dateToString(formatApp)
        
    }
    
    func getDateFromFormat(_ format: String, utcOffset:Int) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.init(secondsFromGMT: utcOffset)
        guard let sourceDate = formatter.date(from: self) else{
            return nil
        }
        return sourceDate
    }
}

extension Date  {
    func dateToString(_ formatApp: String? = "") -> String {
        let formatter2 = DateFormatter()
        formatter2.locale = Locale.current
        formatter2.timeZone = TimeZone.current

        if let formatApp = formatApp, formatApp.count > 0 {
            formatter2.dateFormat = formatApp
        }else {
            formatter2.dateFormat = DateFormat.DATE_APP_FORMAT.rawValue
        }
        if let localTime = formatter2.string(from: self) as String?{
            print("local time %@",localTime)
            print("TimeZone %@",TimeZone.current)
            return localTime
        }
        return ""
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
    
    
}
