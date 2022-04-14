//
//  File.swift
//  sample
//
//  Created by KenNguyen 15/10/2021.
//

import Foundation
typealias CompletionHandle = (Result<SignInEntity, DataTransferError>) -> Void
typealias CompletionProfileHandle = (Result<UserEntity, DataTransferError>) -> Void


class SignInModel : Decodable {
    var accessToken : String?
    var expiresIn : Int?
    var refreshToken : String?
    var tokenChangePassword : String?
    var user : UserResponse.UserDTO?
    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case expiresIn = "expiresIn"
        case refreshToken = "refreshToken"
        case tokenChangePassword = "tokenChangePassword"
        case user = "user"
    }
}


extension SignInModel {
    func toDomain() -> SignInEntity {
        return .init(accessToken: accessToken, refreshToken: refreshToken, expiresIn: expiresIn,tokenChangePassword:tokenChangePassword, user: user?.toDomain())
    }
}


