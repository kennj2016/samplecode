//
//  DefaultMessageRepository.swift
//  SampleCode
//
//  Created by  KenNguyen
// **Note**: DTOs structs are mapped into Domains here, and Repository protocols does not contain DTOs

import Foundation

final class DefaultMessageRepository {

    private let dataTransferService: DataTransferService
    private let cache: UserResponseStorage

    init(dataTransferService: DataTransferService, cache: UserResponseStorage) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}

extension DefaultMessageRepository: ChatRepository {

    public func fetchUserList(query: UserQuery, page: Int,loadding : Bool,
                                cached: @escaping (UserPage) -> Void,
                                completion: @escaping (Result<UserPage, Error>) -> Void) -> Cancellable? {
        let requestDTO = RequestModel(query: query.query, page: page)
        let task = RepositoryTask()

        cache.getResponse(for: requestDTO) { result in

            if case let .success(responseDTO?) = result {
                cached(responseDTO.toDomain())
            }
            guard !task.isCancelled else { return }

            let endpoint = APIAccount.getUser(with: requestDTO)
            task.networkTask = self.dataTransferService.request(with: endpoint, loadding: loadding) { result in
                switch result {
                case .success(let responseDTO):
                    self.cache.save(response: responseDTO, for: requestDTO)
                    completion(.success(responseDTO.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        return task
    }
}
