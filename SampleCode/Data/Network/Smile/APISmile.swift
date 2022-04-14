//
//  APIProfile.swift
//  sample
//
//  Created by KenNguyen 25/10/2021.
//

import Foundation
struct APISmile {
    static func getUser(with requestModel:RequestModel) ->Endpoint<UserResponse> {
        return Endpoint(path: "/api/auth/account/user", method: .post, queryParametersEncodable: requestModel)
    }
    
}
