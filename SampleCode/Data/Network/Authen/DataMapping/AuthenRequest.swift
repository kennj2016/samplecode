//
//  AuthenRequest.swift
//  sample
//
//  Created by KenNguyen 15/10/2021.
//

import Foundation
struct SigInRequest: Encodable {
    let username: String
    let password: String
    let deviceToken: String
}

struct SignUpRequest: Encodable {
    let username: String
    let email: String
    let password: String
    let deviceToken: String
}

struct SigInRequestABCCCCC: Encodable {
    let username: String
    let password: String
    let deviceToken: String
}
