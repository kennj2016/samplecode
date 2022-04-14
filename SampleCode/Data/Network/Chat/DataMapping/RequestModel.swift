//
//  RequestModel.swift
//  SampleCode
//
//  Created by KenNguyen 04/10/2021.
//

import Foundation

struct RequestModel: Encodable {
    let query: String
    let page: Int
}
