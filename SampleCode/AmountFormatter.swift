//
//  AmountFormatter.swift
//  AppShared
//
//  Created by KenNguyen 07/12/2021.
//

import Foundation

public struct AmountFormatter {
    public static let defaultDecimal = 2
    public static let defaultLang = "en"

    public private(set) var decimal: Int
    public private(set) var lang: String

    public init(decimal: Int, lang: String) {
        self.decimal =  decimal
        self.lang = lang
    }
    
    public static func `default`() -> AmountFormatter {
        return AmountFormatter(decimal: Self.defaultDecimal, lang: Self.defaultLang)
    }

    public func format(amount: Double, currency: String) -> String {
        if lang == "ar" {
            if amount < 0 {
                return showNegativeAmountInAR(amount: amount, currency: currency)
            } else {
                return showArAmount(amount: amount, currency: currency)
            }
        }

        return showNormalAmount(amount: amount, currency: currency)
    }
    
    private func showNegativeAmountInAR(amount: Double, currency: String) -> String {
        let cur = AmountCurrency(currency: currency, lang: lang)
        return String(format: "%.\(decimal)f- %@", abs(amount), cur.format())
    }

    private func showArAmount(amount: Double, currency: String) -> String {
        let cur = AmountCurrency(currency: currency, lang: lang)
        return String(format: "%.\(decimal)f %@", abs(amount), cur.format())
    }
    
    private func showNormalAmount(amount: Double, currency: String) -> String {
        let cur = AmountCurrency(currency: currency, lang: lang)
        return String(format: "%@ %.\(decimal)f", cur.format(), amount)
    }
}
