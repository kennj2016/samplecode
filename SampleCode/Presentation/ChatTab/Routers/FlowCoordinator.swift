//
//  ChatSearchFlowCoordinator.swift
//  SampleCode
//
//  Created by  KenNguyen on 03.03.19.
//

import UIKit

protocol FlowCoordinatorDependencies  {
    func makeSignInViewController(actions: AuthenViewModelActions) -> SignInVC
    func makeSettingViewController(actions: AuthenViewModelActions) -> SettingsVC
    func makeProfileViewController(user: UserEntity) -> ProfileVC
    func makeChatListViewController(actions: ChatListViewModelActions) -> ChatVC
    func makeChatDetailsViewController(user: UserEntity) -> UIViewController
    func makeCountryViewController() -> CountryVC

}

final class FlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: FlowCoordinatorDependencies
    private weak var chatVC: ChatVC?
    private weak var settingVC: SettingsVC?

    private weak var tabbar: BaseTabbarViewController?
    init(navigationController: UINavigationController,
         dependencies: FlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        // Note: here we keep strong reference with actions, this way this flow do not need to be strong referenced
        let actions = ChatListViewModelActions(showUserDetails: gotoChatMessage)
        let actionsV5 = AuthenViewModelActions(gotoMainApp: gotoProfile)
        let vc1 = dependencies.makeChatListViewController(actions: actions)
        let vc5 = dependencies.makeSettingViewController(actions: actionsV5)
        let tab = BaseTabbarViewController()
        tab.setupTabbar(v1: vc1, v5: vc5)
        self.navigationController?.setRootViewController(tab)
        tabbar = tab
        chatVC = vc1
        settingVC = vc5

    }
    
    private func gotoChatMessage(user: UserEntity) {
        let vc = dependencies.makeChatDetailsViewController(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func gotoProfile(user: UserEntity) {
        let vc = dependencies.makeProfileViewController(user: user)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func login() {
        self.navigationController?.pushViewController(SignInSignUpVC(), animated: true)
    }
    
    func gotoSignIn() {
        let actions = AuthenViewModelActions(gotoMainApp: gotoChatMessage)
        let vc = dependencies.makeSignInViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: true)

    }
    
    func gotoProfile111(user: UserEntity) {
        self.gotoProfile(user: user)
    }
    
    private func gotoMainApp(user: UserEntity) {
        self.start()
    }
    
    func countryVC() -> CountryVC {
        return dependencies.makeCountryViewController()
    }
}
