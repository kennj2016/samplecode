//
//  File.swift
//  sample
//
//  Created by KenNguyen 15/10/2021.
//

import Foundation
final class DefaultAuthenQueriesRepository {
    
    private let dataTransferService: DataTransferService
    private var queriesPersistentStorage: QueriesStorage
    
    init(dataTransferService: DataTransferService,
         queriesPersistentStorage: QueriesStorage) {
        self.dataTransferService = dataTransferService
        self.queriesPersistentStorage = queriesPersistentStorage
    }
}

extension DefaultAuthenQueriesRepository: AuthenQueriesRepository {
    func saveToken(query: SigInRequestABCCCCC, completion: @escaping CompletionHandle) {
        return queriesPersistentStorage.saveToken(query: query, completion: completion)
    }
   
    
}
