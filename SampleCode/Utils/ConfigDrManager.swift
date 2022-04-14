//
//  SampleCodeConfigManager.swift
//  SampleCode
//
//  Created by  KenNguyen on 26/09/2021.
//

import SideMenuSwift
import Toast_Swift
import IQKeyboardManagerSwift

class ConfigDrManager {
    
    static let shared = ConfigDrManager()
    
    private init() {}

    let fullnameMaxLength = 60

    let phoneMaxLength = 12

    let otpMaxLength = 6
    
    let sideMenuMargin: CGFloat = 45.0.asDesigned
    
    var toastStyle = ToastStyle()
    
    func setupLeftSideMenu(window: UIWindow?) {
        guard let window = window else { return }
        let windowWidth = window.frame.width
        SideMenuController.preferences.basic.menuWidth = windowWidth - sideMenuMargin
        SideMenuController.preferences.basic.statusBarBehavior = .hideOnMenu
        SideMenuController.preferences.basic.position = .above
        SideMenuController.preferences.basic.direction = .left
        SideMenuController.preferences.basic.enablePanGesture = true
        SideMenuController.preferences.basic.supportedOrientations = .portrait
        SideMenuController.preferences.basic.shouldRespectLanguageDirection = true
    }
    
    func setupIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 20.asDesigned
    }
    
    func setupToaster() {
        toastStyle.backgroundColor = ColorDr.blue.value
        toastStyle.maxWidthPercentage = 0.8
        
        if let font = UIFont(name: FontDrName.regular.rawValue, size: 16.asDesigned) {
            toastStyle.messageFont =  font
        }
        
        ToastManager.shared.style = toastStyle
    }
    
}
