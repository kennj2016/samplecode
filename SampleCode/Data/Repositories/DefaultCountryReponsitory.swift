//
//  DefaultCountryReponsitory.swift
//  sample
//
//  Created by KenNguyen 26/10/2021.
//

import Foundation
final class DefaultCountryReponsitory {

    private let dataTransferService: DataTransferService
    private let task = RepositoryTask()

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultCountryReponsitory: CountryRepository {
    func findCountry(request: CountryRequest, loadding: Bool, completion: @escaping CompletionCountryFindHandle) -> Cancellable? {
        let endpoint = APICountry.findCountry(with: request)
        task.networkTask = self.dataTransferService.request(with: endpoint, loadding: loadding) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
    
    func allCountry(loadding: Bool, completion: @escaping CompletionCountryHandle) -> Cancellable? {
        let endpoint = APICountry.allCountry()
        task.networkTask = self.dataTransferService.request(with: endpoint, loadding: loadding) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.map({$0.toDomain()})))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
    
}
