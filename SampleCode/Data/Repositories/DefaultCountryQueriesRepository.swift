//
//  DefaultCountryQueriesRepository.swift
//  sample
//
//  Created by KenNguyen 26/10/2021.
//

import Foundation
final class DefaultCountryQueriesRepository {
    
    private let dataTransferService: DataTransferService
    private var queriesPersistentStorage: QueriesStorage
    
    init(dataTransferService: DataTransferService,
         queriesPersistentStorage: QueriesStorage) {
        self.dataTransferService = dataTransferService
        self.queriesPersistentStorage = queriesPersistentStorage
    }
}

extension DefaultCountryQueriesRepository: CountryQueriesRepository {
    func saveCountry(query: SigInRequestABCCCCC, completion: @escaping CompletionCountryHandle) {
        return queriesPersistentStorage.saveCountry(query: query, completion: completion)
    }
    
}
