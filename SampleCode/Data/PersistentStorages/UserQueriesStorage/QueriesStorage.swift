//
//  ChatQueriesStorage.swift
//  SampleCode
//
//  Created by  KenNguyen on 10.10.21.
//

import Foundation

protocol QueriesStorage {
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[UserQuery], Error>) -> Void)
    func saveRecentQuery(query: UserQuery, completion: @escaping (Result<UserQuery, Error>) -> Void)
    func saveToken(query: SigInRequestABCCCCC, completion: @escaping CompletionHandle)
    func saveCountry(query: SigInRequestABCCCCC, completion: @escaping CompletionCountryHandle) 
}
