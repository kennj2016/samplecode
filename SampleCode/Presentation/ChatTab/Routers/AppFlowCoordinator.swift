//
//  AppFlowCoordinator.swift
//  SampleCode
//
//  Created by  KenNguyen on 03.03.19.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    var flow:FlowCoordinator {
        let sceneDIContainer = appDIContainer.makeSceneDIContainer()
        return sceneDIContainer.makeFlowCoordinator(navigationController: navigationController)
    }

    func start() {
        flow.start()
    }
    
    func login() {
        if AppConfiguration.autoLogin() {
            self.start()
        }else {
            flow.login()
        }
    }
    
    func gotoSignIn() {
        flow.gotoSignIn()
    }
    
    func gotoProfile() {
    }
}
