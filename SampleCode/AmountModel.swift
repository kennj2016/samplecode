//
//  OrderModel.swift
//  tamara_pay
//
//  Created by KenNguyen 7/24/20.
//  Copyright © 2020 Thanh Pham. All rights reserved.
//

import Foundation

public struct AmountModel: Codable {
    public var amount: Double?
    public var currency: String?
    
    public init(amount: Double, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    public static func + (leftAmount: AmountModel, rightAmount: AmountModel) -> AmountModel {
        return .init(
            amount: (leftAmount.amount ?? 0) + (rightAmount.amount ?? 0),
            currency: leftAmount.currency ?? (rightAmount.currency ?? "")
        )
    }
    
    public static func - (leftAmount: AmountModel, rightAmount: AmountModel) -> AmountModel {
        return .init(
            amount: (leftAmount.amount ?? 0) - (rightAmount.amount ?? 0),
            currency: leftAmount.currency ?? (rightAmount.currency ?? "")
        )
    }

    public func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        if self.amount != nil {
            dict["amount"] = self.amount
        }
        
        if self.currency != nil {
            dict["currency"] = self.currency
        }
        return dict
    }
    
    public func asText(formatter: AmountFormatter = AmountFormatter.default()) -> String {
        return formatter.format(amount: amount ?? 0, currency: currency ?? "")
    }
    
    public static func total(items: [AmountModel]) -> AmountModel {
        let amount = items.compactMap { $0.amount }
            .reduce(0, + )
        return .init(amount: amount, currency: items.first?.currency ?? "")
    }
}
