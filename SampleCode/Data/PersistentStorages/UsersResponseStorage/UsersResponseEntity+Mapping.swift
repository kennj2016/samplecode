//
//  ChatResponseEntity+Mapping.swift
//  SampleCode
//
//  Created by  KenNguyen on 05/04/2020.
//

import Foundation
import CoreData

extension UserListResponseEntity {
//    func toDTO() -> ListUserResponse {
//        return .init(page: Int(page),
//                     totalPages: Int(totalPages),
//                     users: users?.allObjects.map { ($0 as! UserResponseEntity).toDTO() } ?? [])
//    }
}

extension UserResponseEntity {
//    func toDTO() -> ListUserResponse.UserDTO {
//        return .init(activeLeaderAt: "", activeLeaderBy: "", avatar: avatar, countryCode: "", cover: "", dateOfBirth: "", defaultStatus: 0, displayname: "", email: "", firstName: "", gender: 0, id: id, isActive: false, isActiveLeader: false, isOnline: false, kycStatus: 0, lang: "", lastName: "", level: "", maritalStatus: 0, middleName: "", nationality: "", nickName: "", phone: "", qrCodeImage: "", reputationRating: 0, requiredChangePassNextLogin: false, role: [], theme: "", totalFollower: 0, totalSmile: 0, type: 0, username: username, utcOffset: 0)
//    }
}

extension RequestModel {
    func toEntity(in context: NSManagedObjectContext) -> UserRequestEntity {
        let entity: UserRequestEntity = .init(context: context)
        entity.query = query
        entity.page = Int32(page)
        return entity
    }
}

extension UserResponse {
    func toEntity(in context: NSManagedObjectContext) -> UserListResponseEntity {
        let entity: UserListResponseEntity = .init(context: context)
        entity.page = Int32(page)
        entity.totalPages = Int32(totalPages)
        users.forEach {
            entity.addToUsers($0.toEntity(in: context))
        }
        return entity
    }
}

extension UserResponse.UserDTO {
    func toEntity(in context: NSManagedObjectContext) -> UserResponseEntity {
        let entity: UserResponseEntity = .init(context: context)
        entity.id = id
        entity.avatar = avatar
        entity.username = username
        entity.nickName = nickName
        entity.displayName = displayname
        return entity
    }
}

