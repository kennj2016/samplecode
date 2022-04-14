//
//  ChatRepositoryInterfaces.swift
//  SampleCode
//
//  Created by  KenNguyen

import Foundation

protocol ChatRepository {
    @discardableResult
    func fetchUserList(query: UserQuery, page: Int,loadding: Bool,
                         cached: @escaping (UserPage) -> Void,
                         completion: @escaping (Result<UserPage, Error>) -> Void) -> Cancellable?
}
