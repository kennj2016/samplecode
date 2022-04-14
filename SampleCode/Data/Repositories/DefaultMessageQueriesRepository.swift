//
//  DefaultMessageQueriesRepository.swift
//  SampleCode
//
//  Created by  KenNguyen on 10.10.21.
//

import Foundation

final class DefaultMessageQueriesRepository {
    
    private let dataTransferService: DataTransferService
    private var queriesPersistentStorage: QueriesStorage
    
    init(dataTransferService: DataTransferService,
         queriesPersistentStorage: QueriesStorage) {
        self.dataTransferService = dataTransferService
        self.queriesPersistentStorage = queriesPersistentStorage
    }
}

extension DefaultMessageQueriesRepository: ChatQueriesRepository {
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[UserQuery], Error>) -> Void) {
        return queriesPersistentStorage.fetchRecentsQueries(maxCount: maxCount, completion: completion)
    }
    
    func saveRecentQuery(query: UserQuery, completion: @escaping (Result<UserQuery, Error>) -> Void) {
        queriesPersistentStorage.saveRecentQuery(query: query, completion: completion)
    }
}
