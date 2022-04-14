//
//  SearchUserUseCase.swift
//  SampleCode
//
//  Created by  KenNguyen on 22.02.19.
//

import Foundation

protocol SearchUserUseCase {
    func execute(requestValue: SearchChatUseCaseRequestValue,loadding: Bool,
                 cached: @escaping (UserPage) -> Void,
                 completion: @escaping (Result<UserPage, Error>) -> Void) -> Cancellable?
}

final class DefaultSearchUserUseCase: SearchUserUseCase {

    private let chatRepository: ChatRepository
    private let chatQueriesRepository: ChatQueriesRepository

    init(chatRepository: ChatRepository,
         chatQueriesRepository: ChatQueriesRepository) {

        self.chatRepository = chatRepository
        self.chatQueriesRepository = chatQueriesRepository
    }

    func execute(requestValue: SearchChatUseCaseRequestValue,loadding: Bool,
                 cached: @escaping (UserPage) -> Void,
                 completion: @escaping (Result<UserPage, Error>) -> Void) -> Cancellable? {

        return chatRepository.fetchUserList(query: requestValue.query,
                                            page: requestValue.page, loadding: loadding,
                                                cached: cached,
                                                completion: { result in

            if case .success = result {
                self.chatQueriesRepository.saveRecentQuery(query: requestValue.query) { _ in }
            }

            completion(result)
        })
    }
}

struct SearchChatUseCaseRequestValue {
    let query: UserQuery
    let page: Int
}
