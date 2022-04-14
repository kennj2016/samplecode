//
//  File.swift
//  sample
//
//  Created by KenNguyen 18/10/2021.
//

import Foundation
struct OtpRequest: Encodable {
    let userName: String
}
struct ConfirmOtpRequest: Encodable {
    let userName: String
    let code: String

}
struct ResetPasswordRequest: Encodable {
    let userName: String
    let code: String
    let password: String
}
struct UpdateProfileRequest: Encodable {
    let nickname: String
    let phone: String
    let fullname: String
    let birthDay: String
    let gender: Int
    let countryCode: String
    let maritalStatus: Int

}
