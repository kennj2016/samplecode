//
//  FetchRecentMovieQueriesUseCase.swift
//  SampleCode
//
//  Created by  KenNguyen on 11.08.19.
//

import Foundation

// This is another option to create Use Case using more generic way
final class FetchRecentChatQueriesUseCase: UseCase {

    struct RequestValue {
        let maxCount: Int
    }
    typealias ResultValue = (Result<[UserQuery], Error>)

    private let requestValue: RequestValue
    private let completion: (ResultValue) -> Void
    private let chatQueriesRepository: ChatQueriesRepository

    init(requestValue: RequestValue,
         completion: @escaping (ResultValue) -> Void,
         chatQueriesRepository: ChatQueriesRepository) {

        self.requestValue = requestValue
        self.completion = completion
        self.chatQueriesRepository = chatQueriesRepository
    }
    
    func start() -> Cancellable? {

        chatQueriesRepository.fetchRecentsQueries(maxCount: requestValue.maxCount, completion: completion)
        return nil
    }
}
