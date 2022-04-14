//
//  CountryRequest.swift
//  sample
//
//  Created by KenNguyen 26/10/2021.
//

import Foundation
struct CountryRequest: Encodable {
    let keyword: String
    let pageNumber: Int
    let pageSize: Int
}
