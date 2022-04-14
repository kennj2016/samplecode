//
//  ChatListItemViewModel.swift
//  SampleCode
//
//  Created by  KenNguyen on 06/04/2020.
//
// **Note**: This item view model is to display data and does not contain any domain model to prevent views accessing it

import Foundation

struct UserViewModel: Equatable {
    let name: String
    let username: String
    let avatar: String
    let isverify: Bool
}

extension UserViewModel {
    init(user: UserEntity) {
        self.name = user.displayName ?? ""
        self.username = user.username ?? ""
        self.avatar = user.avatar ?? ""
        self.isverify = user.isOnline ?? false
    }
}

