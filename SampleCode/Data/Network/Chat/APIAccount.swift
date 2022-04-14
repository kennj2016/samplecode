//
//  APIEndpoints.swift
//  SampleCode
//
//  Created by  KenNguyen

import Foundation

struct APIAccount {
    static func getUser(with requestModel:RequestModel) ->Endpoint<UserResponse> {
        return Endpoint(path: "/api/auth/account/user", method: .post, queryParametersEncodable: requestModel, responseDecoder: RawDataResponseDecoder())
    }
    
}
