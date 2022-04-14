//
//  ChatSceneDIContainer.swift
//  SampleCode
//
//  Created by  KenNguyen on 03.03.19.
//

import UIKit
import SwiftUI

final class SceneDIContainer: FlowCoordinatorDependencies {
    
    
  
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    lazy var appConfiguration = AppConfiguration()

    // MARK: - Persistent Storage
    lazy var queriesStorage: QueriesStorage = CoreDataQueriesStorage(maxStorageLimit: 10)

    init(dependencies: Dependencies) {
        self.dependencies = dependencies        
    }
    
    // MARK: - Use Cases
    func makeSearchUserUseCase() -> SearchUserUseCase {
        
        return DefaultSearchUserUseCase.init(chatRepository: makeMessageRepository(),
                                             chatQueriesRepository: makeUserQueriesRepository())
    }
    
    
    func makeAuthenUseCase() ->AuthenUseCase {
        return DefaultAuthenUseCase.init(authenRepository: makeAuthenRepository(), authenQueriesRepository: makeAuthenQueriesRepository())
    }
    
    func makeCountryUseCase() ->CountryUseCase {
        return DefaultCountryUseCase.init(countryRepository: makeCountryRepository(), countryQueriesRepository: makeCountryQueriesRepository())
    }
    
    
    
    // MARK: - Repositories authen
    func makeAuthenRepository() -> DefaultAuthenReponsitory {
        let trans = DefaultDataTransferService.init(with: DefaultNetworkService.init(config: ApiDataNetworkConfig.init(baseURL: URL.init(string: appConfiguration.apiBaseURL)!)))
        return DefaultAuthenReponsitory.init(dataTransferService: trans)
    }
    func makeAuthenQueriesRepository() -> AuthenQueriesRepository {
        let trans = DefaultDataTransferService.init(with: DefaultNetworkService.init(config: ApiDataNetworkConfig.init(baseURL: URL.init(string: appConfiguration.apiBaseURL)!)))
        let queriesRepository = DefaultAuthenQueriesRepository.init(dataTransferService: trans, queriesPersistentStorage: UserDefaultsQueriesStorage.init(maxStorageLimit: 10))
        return queriesRepository 
    }
    
    // MARK: - Repositories country
    func makeCountryRepository() -> DefaultCountryReponsitory {
        let trans = DefaultDataTransferService.init(with: DefaultNetworkService.init(config: ApiDataNetworkConfig.init(baseURL: URL.init(string: appConfiguration.apiBaseURL)!)))
        return DefaultCountryReponsitory.init(dataTransferService: trans)
    }
    func makeCountryQueriesRepository() -> CountryQueriesRepository {
        let trans = DefaultDataTransferService.init(with: DefaultNetworkService.init(config: ApiDataNetworkConfig.init(baseURL: URL.init(string: appConfiguration.apiBaseURL)!)))
        let queriesRepository = DefaultCountryQueriesRepository.init(dataTransferService: trans, queriesPersistentStorage: UserDefaultsQueriesStorage.init(maxStorageLimit: 10))
        return queriesRepository
    }
        
    // MARK: - Repositories
    func makeMessageRepository() -> DefaultMessageRepository {
        let trans = DefaultDataTransferService.init(with: DefaultNetworkService.init(config: ApiDataNetworkConfig.init(baseURL: URL.init(string: appConfiguration.apiBaseURL)!)))
        return DefaultMessageRepository.init(dataTransferService: trans, cache: CoreDataResponseStorage.init())
    }
    
    func makeUserQueriesRepository() -> ChatQueriesRepository {
        let trans = DefaultDataTransferService.init(with: DefaultNetworkService.init(config: ApiDataNetworkConfig.init(baseURL: URL.init(string: appConfiguration.apiBaseURL)!)))
        let queriesRepository = DefaultMessageQueriesRepository.init(dataTransferService: trans, queriesPersistentStorage: UserDefaultsQueriesStorage.init(maxStorageLimit: 10))
        return queriesRepository
    }
    
    //Mark: Viewcotroller
    func makeCountryViewController() -> CountryVC {
        return CountryVC.create(with: makeCountryViewModel())
    }
    
    
    func makeProfileViewController(user: UserEntity) -> ProfileVC {
        return ProfileVC()
    }
    
    func makeSignInViewController(actions: AuthenViewModelActions) -> SignInVC {
        return SignInVC.create(with: makeAuthenViewModel(actions: actions))
    }
    
    func makeSettingViewController(actions: AuthenViewModelActions) -> SettingsVC {
        return SettingsVC.create(with: makeAuthenViewModel(actions: actions))
    }


    func makeAuthenViewModel(actions: AuthenViewModelActions) -> AuthenViewModel {
        return DefaultAuthenViewModel(authenUseCase: makeAuthenUseCase(), actions: actions)
    }
    
    func makeCountryViewModel() -> CountryViewModel {
        return DefaultCountryViewModel(countryUseCase: makeCountryUseCase())
    }
    
    func makeChatListViewController(actions: ChatListViewModelActions) -> ChatVC {
        return ChatVC.create(with: makeChatListViewModel(actions: actions))
    }
    
    func makeChatListViewModel(actions: ChatListViewModelActions) -> ChatListViewModel {
        return DefaultUserListViewModel(searchChatUseCase: makeSearchUserUseCase(),
                                          actions: actions)
    }
//    // MARK: - Movie Details
    func makeChatDetailsViewController(user: UserEntity) -> UIViewController {
        return MessagesVC()
    }

//    // MARK: - Flow Coordinators
    func makeFlowCoordinator(navigationController: UINavigationController) -> FlowCoordinator {
        return FlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
    
}

