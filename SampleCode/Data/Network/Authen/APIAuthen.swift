//
//  APIAuthen.swift
//  sample
//
//  Created by KenNguyen 15/10/2021.
//

import Foundation
struct APIAuthen {
    static func signin(with requestModel:SigInRequest) ->Endpoint<SignInModel> {
        return Endpoint(path: "api/auth/account/login", method: .post, bodyParamatersEncodable: requestModel)
    }
    
    static func getOTP(with requestModel:OtpRequest) ->Endpoint<String> {
        return Endpoint(path: "api/auth/account/send-otp-change-password", method: .post, bodyParamatersEncodable: requestModel)
    }
    
    
    static func confirmOTP(with requestModel:ConfirmOtpRequest) ->Endpoint<String> {
        return Endpoint(path: "api/auth/account/confirm-otp", method: .post, bodyParamatersEncodable: requestModel)
    }
    static func resetPassword(with requestModel:ResetPasswordRequest) ->Endpoint<String> {
        return Endpoint(path: "api/auth/account/reset-password", method: .post, bodyParamatersEncodable: requestModel)
    }
    
    static func singup(with requestModel:SignUpRequest) ->Endpoint<SignInModel> {
        return Endpoint(path: "api/auth/account/register", method: .post, bodyParamatersEncodable: requestModel)
    }
    
    static func profile() ->Endpoint<UserResponse.UserDTO?> {
        return Endpoint(path: "api/auth/account/profile", method: .get)
    }
    
    static func updateProfile(with requestModel:UpdateProfileRequest) ->Endpoint<UserResponse.UserDTO?> {
        return Endpoint(path: "api/auth/account/edit-profile", method: .post,bodyParamatersEncodable: requestModel)
    }
}
