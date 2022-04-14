//
//  ProfileViewModel.swift
//  sample
//
//  Created by KenNguyen 25/10/2021.
//

import Foundation
import Foundation

struct ProfileViewModel: Equatable {
    let name: String
    let username: String
    let avatar: String
    let fullName: String
    let bod: String
    let gender: String
    let national: String
    let marriedStatus: String
    let kycStatus: EkycStatus
    let isActiveLeader: Bool
    let cover: String
    let totalSmile: Int
    let totalFollower: Int
    let reputationRating: Float
    let nickName: String

    private let non = "---"
    
}

extension ProfileViewModel {
    init(user: UserEntity) {
        self.name = user.displayName ?? non
        self.username = user.username ?? non
        self.avatar = user.avatar ?? ""
        self.fullName = user.displayName ?? non
        if let bod = user.bod?.dateToString(DateFormat.apiCases, utcOffset: user.utcOffset ?? 0) {
            self.bod = bod
        }else {
            self.bod = non
        }
        if let gender = user.gender, let genderStatus = UserGender.init(rawValue: gender) {
            self.gender = genderStatus.textValue
        }else {
            self.gender = non
        }
        
        self.national = user.national ?? non
        if let marriedStatus = user.marriedStatus, let status = MaritalStatus.init(rawValue: marriedStatus) {
            self.marriedStatus = status.textValue.capitalizingFirstLetter()
        }else {
            self.marriedStatus = non
        }
        self.kycStatus = EkycStatus.init(rawValue: user.kycStatus ?? 0) ?? .NOT_VERIFY
        self.isActiveLeader = user.isActiveLeader ?? false
        self.cover = user.cover ?? ""
        self.totalSmile = user.totalSmile ?? 0
        self.totalFollower = user.totalFollower ?? 0
        self.reputationRating = user.reputationRating ?? 0.0
       
        var nick = user.nickName ?? ""
        if nick.count == 0 {
            nick = user.username ?? ""
        }
        self.nickName = "@\(nick)"

    }
}

