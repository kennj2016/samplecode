//
//  AppDelegate.swift
//  SampleCode
//
//  Created by  KenNguyen on 03/06/2021.
//

import UIKit
import CoreData
import SideMenuSwift

let SHARE_APPLICATION_DELEGATE = UIApplication.shared.delegate as! AppDelegate

@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        AppConfiguration.resetData()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        
        window?.rootViewController = navigationController
        appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController,
                                                appDIContainer: appDIContainer)
        appFlowCoordinator?.login()
//        self.window?.rootViewController = UINavigationController(rootViewController: ProfileVC())
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
}
