//
//  AuthenError.swift
//  sample
//
//  Created by KenNguyen 17/10/2021.
//

import Foundation

struct ErrorModel : Decodable {
    let error : ErrorDTO?
    enum CodingKeys: String, CodingKey {
        case error = "error"
    }
}
extension ErrorModel {
    struct ErrorDTO : Decodable {
        let code : String?
        let message : String?
        enum CodingKeys: String, CodingKey {
            case code = "code"
            case message = "message"
        }
    }
}
extension ErrorModel.ErrorDTO {
    func toDomain() -> ErrorEntity {
        return .init(code: self.code, message: self.message)
    }
}
