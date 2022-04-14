//
//  ChatResponseStorage.swift
//  SampleCode
//
//  Created by  KenNguyen on 05/04/2020.
//

import Foundation

protocol UserResponseStorage {
    func getResponse(for request: RequestModel, completion: @escaping (Result<UserResponse?, CoreDataStorageError>) -> Void)
    func save(response: UserResponse, for requestDto: RequestModel)
}
