//
//  Movie.swift
//  SampleCode
//
//  Created by  KenNguyen

import Foundation
struct SignInEntity : Equatable {
    
    let accessToken : String?
    let refreshToken : String?
    let expiresIn : Int?
    let tokenChangePassword : String?
    let user : UserEntity?
}

struct UserEntity : Equatable {
    
    let id : String?
    let avatar : String?
    let username : String?
    let nickName : String?
    let displayName : String?
    let defautlStatus : Int?
    let bod: String?
    let gender: Int?
    let national: String?
    let marriedStatus: Int?
    let isOnline : Bool?
    let utcOffset: Int?
    let kycStatus: Int?
    let isActiveLeader: Bool?
    let cover: String?
    let totalSmile: Int?
    let totalFollower: Int?
    let reputationRating: Float?

}


struct UserPage: Equatable {
    let page: Int
    let totalPages: Int
    let users: [UserEntity]
}

