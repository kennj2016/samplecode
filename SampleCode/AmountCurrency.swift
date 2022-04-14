//
//  AmountCurrency.swift
//  AppShared
//
//  Created by KenNguyen 07/12/2021.
//

import Foundation

public struct AmountCurrency {
    private(set) var currency: String?
    private(set) var lang: String?
    
    public init(currency: String, lang: String) {
        self.currency = currency
        self.lang = lang
    }
    
    public func format() -> String {
        if let currency = currency {
            switch currency {
            case "SAR":
                return currencyKSA()
            case "AED":
                return currencyUAE()
            case "KWD":
                return currencyKWI()
            case "BHD":
                return currencyBHD()
            case "QAR":
                return currencyQAR()
            default:
                return ""
            }
        }
        return ""
    }
    
    private func currencyKSA() -> String {
        return  lang == "en" ? "SAR" : "ر.س"
    }
    
    private func currencyUAE() -> String {
        return  lang == "en" ? "AED" : "د.إ"
    }
    
    private func currencyKWI() -> String {
        return  lang == "en" ? "KWD" : "د.ك"
    }
    
    private func currencyBHD() -> String {
        return  lang == "en" ? "BHD" : "د.ب"
    }
    
    private func currencyQAR() -> String {
        return  lang == "en" ? "QAR" : "ر.ق"
    }
}
