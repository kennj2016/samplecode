//
//  ListUserResponse+Mapping.swift
//  Data
//
//  Created by  KenNguyen on 12.08.19.
//  Copyright © 2019 Oleh Kudinov. All rights reserved.
//

import Foundation

// MARK: - Data Transfer Object

struct UserResponse: Decodable {
    let page: Int
    let totalPages: Int
    let users: [UserDTO]
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalPages = "total_pages"
        case users = "results"
    }
}

extension UserResponse {
    struct UserDTO : Decodable {
            let isOnline : Bool?
            let id : String?
            let dateOfBirth : String?
            let username : String?
            let displayname : String?
            let defaultStatus : Int?
            let utcOffset : Int?
            let isActive : Bool?
            let type : Int?
            let email : String?
            let phone : String?
            let firstName : String?
            let middleName : String?
            let lastName : String?
            let gender : Int?
            let kycStatus : Int?
            let qrCodeImage : String?
            let nickName : String?
            let role : [String]?
            let requiredChangePassNextLogin : Bool?
            let lang : String?
            let countryCode : String?
            let nationality : String?
            let avatar : String?
            let cover : String?
            let reputationRating : Float?
            let totalFollower : Int?
            let totalSmile : Int?
            let isActiveLeader : Bool?
            let activeLeaderBy : String?
            let activeLeaderAt : String?
            let theme : String?
            let level : String?
            let maritalStatus : Int?
            let emailSettingNotice : Int?
            let desktopSettingNotice : Int?
            let pushSettingNotice : Int?
        
    

            enum CodingKeys: String, CodingKey {
                    case isOnline = "isOnline"
                    case id = "id"
                    case dateOfBirth = "dateOfBirth"
                    case username = "username"
                    case displayname = "displayname"
                    case defaultStatus = "defaultStatus"
                    case utcOffset = "utcOffset"
                    case isActive = "isActive"
                    case type = "type"
                    case email = "email"
                    case phone = "phone"
                    case firstName = "firstName"
                    case middleName = "middleName"
                    case lastName = "lastName"
                    case gender = "gender"
                    case kycStatus = "kycStatus"
                    case qrCodeImage = "qrCodeImage"
                    case nickName = "nickName"
                    case role = "role"
                    case requiredChangePassNextLogin = "requiredChangePassNextLogin"
                    case lang = "lang"
                    case countryCode = "countryCode"
                    case nationality = "nationality"
                    case avatar = "avatar"
                    case cover = "cover"
                    case reputationRating = "reputationRating"
                    case totalFollower = "totalFollower"
                    case totalSmile = "totalSmile"
                    case isActiveLeader = "isActiveLeader"
                    case activeLeaderBy = "activeLeaderBy"
                    case activeLeaderAt = "activeLeaderAt"
                    case theme = "theme"
                    case level = "level"
                    case maritalStatus = "maritalStatus"
                    case emailSettingNotice = "emailSettingNotice"
                    case desktopSettingNotice = "desktopSettingNotice"
                    case pushSettingNotice = "pushSettingNotice"
            }
    }


}
// MARK: - Mappings to Domain
extension UserResponse {
    func toDomain() -> UserPage {
        return .init(page: page ,
                     totalPages: totalPages ,
                     users: users.map { $0.toDomain() })
    }
}
extension UserResponse.UserDTO {
    func toDomain() -> UserEntity {
        return .init(id: id, avatar: avatar, username: username, nickName: nickName, displayName: displayname, defautlStatus: 0, bod: dateOfBirth, gender: gender, national: nationality, marriedStatus: maritalStatus, isOnline: true,utcOffset: utcOffset,kycStatus: kycStatus, isActiveLeader:isActiveLeader, cover: cover, totalSmile:totalSmile, totalFollower: totalFollower,reputationRating:reputationRating)
    }
}
