//
//  ChatListViewModel.swift
//  SampleCode
//
//  Created by  KenNguyen

import Foundation

struct ChatListViewModelActions {
    let showUserDetails: (UserEntity) -> Void
}

enum ChatListViewModelLoading {
    case fullScreen
    case nextPage
}

protocol ChatListViewModelInput {
    func viewDidLoad()
    func didLoadNextPage()
    func didSearch(query: String)
    func didCancelSearch()
    func didSelectItem(at index: Int)
}

protocol ChatListViewModelOutput {
    var items: Observable<[UserViewModel]> { get } /// Also we can calculate view model items on demand:  https://github.com/kudoleh/iOS-Clean-Architecture-MVVM/pull/10/files
    var loading: Observable<ChatListViewModelLoading?> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
    var searchBarPlaceholder: String { get }
}

protocol ChatListViewModel: ChatListViewModelInput, ChatListViewModelOutput {}

final class DefaultUserListViewModel: ChatListViewModel {
   
    private let searchChatUseCase: SearchUserUseCase
    private let actions: ChatListViewModelActions?

    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }

    private var pages: [UserPage] = []
    private var usersLoadTask: Cancellable? { willSet { usersLoadTask?.cancel() } }

    // MARK: - OUTPUT

    let items: Observable<[UserViewModel]> = Observable([])
    let loading: Observable<ChatListViewModelLoading?> = Observable(.none)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Users", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search Users", comment: "")

    // MARK: - Init

    init(searchChatUseCase: SearchUserUseCase,
         actions: ChatListViewModelActions? = nil) {
        self.searchChatUseCase = searchChatUseCase
        self.actions = actions
    }

    // MARK: - Private

    private func appendPage(_ usersPage: UserPage) {
        currentPage = usersPage.page
        totalPageCount = usersPage.totalPages

        pages = pages
            .filter { $0.page != usersPage.page }
            + [usersPage]

        items.value = pages.datas.map(UserViewModel.init)
    }

    private func resetPages() {
        currentPage = 0
        totalPageCount = 1
        pages.removeAll()
        items.value.removeAll()
    }

    private func load(userQuery: UserQuery, loading: ChatListViewModelLoading) {
        self.loading.value = loading
        query.value = userQuery.query

        usersLoadTask = searchChatUseCase.execute(
            requestValue: .init(query: userQuery, page: nextPage), loadding: true,
            cached: appendPage,
            completion: { result in
                switch result {
                case .success(let page):
                    self.appendPage(page)
                case .failure(let error):
                    self.handle(error: error)
                }
                self.loading.value = .none
        })
    }

    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading User", comment: "")
    }

    private func update(userQuery: UserQuery) {
        resetPages()
        load(userQuery: userQuery, loading: .fullScreen)
    }
}

// MARK: - INPUT. View event methods

extension DefaultUserListViewModel {

    func viewDidLoad() { }

    func didLoadNextPage() {
        guard hasMorePages, loading.value == .none else { return }
        load(userQuery: .init(query: query.value),
             loading: .nextPage)
    }

    func didSearch(query: String) {
        guard !query.isEmpty else { return }
        update(userQuery: UserQuery(query: query))
    }

    func didCancelSearch() {
        usersLoadTask?.cancel()
    }

    func didSelectItem(at index: Int) {
//        actions?.showUserDetails(pages.datas[index])
    }
}

// MARK: - Private

private extension Array where Element == UserPage {
    var datas: [UserEntity] { flatMap { $0.users } }
}
