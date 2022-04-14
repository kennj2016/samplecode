//
//  CountryEntity.swift
//  sample
//
//  Created by KenNguyen 26/10/2021.
//

import Foundation
struct CountryEntity : Equatable {
    let name : String?
    let code : String?
    let isoCode : String?
    let index : Int?
    let id : String?
    let nationality : String?
}


struct CountryPage: Equatable {
    let page: Int
    let totalPages: Int
    let datas: [CountryEntity]
}
