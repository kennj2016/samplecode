//
//  CountryResponse.swift
//  sample
//
//  Created by KenNguyen 26/10/2021.
//

import Foundation
typealias CompletionCountryFindHandle = (Result<CountryPage, DataTransferError>) -> Void
typealias CompletionCountryHandle = (Result<[CountryEntity], DataTransferError>) -> Void

struct CountryResponse: Decodable {
    let pageInfo: PageDTO
    let pageData: [CountryDTO]
    enum CodingKeys: String, CodingKey {
        case pageInfo = "pageInfo"
        case pageData = "pageData"
    }
}

extension CountryResponse {
    struct CountryDTO : Decodable {
        let name : String?
        let code : String?
        let isoCode : String?
        let index : Int?
        let id : String?
        let nationality : String?
        enum CodingKeys: String, CodingKey {
            case name = "name"
            case code = "code"
            case isoCode = "isoCode"
            case index = "index"
            case id = "id"
            case nationality = "nationality"
        }
    }
    
    struct PageDTO : Decodable {
        let pageNumber : Int?
        let pageSize : Int?
        let totalItemsCount : Int?
        enum CodingKeys: String, CodingKey {
            case pageNumber = "pageNumber"
            case pageSize = "pageSize"
            case totalItemsCount = "totalItemsCount"
        }
    }
    
}
// MARK: - Mappings to Domain
extension CountryResponse {
    func toDomain() -> CountryPage {
        return .init(page: self.pageInfo.pageNumber ?? 0 ,
                     totalPages: self.pageInfo.totalItemsCount ?? 0,
                     datas: self.pageData.map { $0.toDomain() })
    }
}

extension CountryResponse.CountryDTO {
    func toDomain() -> CountryEntity {
        return .init(name: name, code: code, isoCode: isoCode, index: index, id: id, nationality: nationality)
    }
}

