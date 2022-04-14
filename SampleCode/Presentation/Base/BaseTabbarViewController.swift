//
//  BaseTabbarViewController.swift
//  SampleCode
//
//  Created by  KenNguyen on 7/10/21.
//

import UIKit

class BaseTabbarViewController: ESTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupTabbar(v1:ChatVC, v5: SettingsVC) {
        
        self.delegate = delegate
        if #available(iOS 13, *) {
            let appearance = self.tabBar.standardAppearance
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            appearance.backgroundColor = ColorDr.white_text.value
            self.tabBar.standardAppearance = appearance;
        }else {
            tabBar.shadowImage = UIImage()
            tabBar.backgroundImage = UIImage()
        }

        
        self.tabBar.barTintColor = ColorDr.white_text.value
        self.tabBar.unselectedItemTintColor = ColorDr.gray_text.value
        self.tabBar.tintColor = ColorDr.blue.value
        self.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                
                return true
            }
            return false
        }
        self.didHijackHandler = { (tabbarController, viewController, index) in
            DispatchQueue.main.async {
                //
            }
        }
        
        let v2 = GroupsVC()
        let v3 = HomeVC()
        let v4 = NetworkVC()
        
        let irregularityContentView = ExampleIrregularityContentView()
        irregularityContentView.insets = edgeInsetCenter(true)
        
        v1.tabBarItem = UITabBarItem.init(title: TabbarValue.chat.rawValue, image:TabbarValue.chat.image , selectedImage: TabbarValue.chat.image)
        v2.tabBarItem = UITabBarItem.init(title: TabbarValue.group.rawValue, image: TabbarValue.group.image, selectedImage: TabbarValue.group.image)
        v3.tabBarItem = ESTabBarItem.init(irregularityContentView, title: nil, image: TabbarValue.home.image, selectedImage:nil)
        v4.tabBarItem = UITabBarItem.init(title: TabbarValue.network.rawValue, image: TabbarValue.network.image, selectedImage: TabbarValue.network.image)
        v5.tabBarItem = UITabBarItem.init(title: TabbarValue.setting.rawValue, image: TabbarValue.setting.image, selectedImage: TabbarValue.setting.image)
        
        v1.tabBarItem.imageInsets = edgeInsetCenter()
        v2.tabBarItem.imageInsets = edgeInsetCenter()
        v3.tabBarItem.imageInsets = edgeInsetCenter(true)
        v4.tabBarItem.imageInsets = edgeInsetCenter()
        v5.tabBarItem.imageInsets = edgeInsetCenter()

        let nav1 = UINavigationController(rootViewController: v1)
        let nav2 = UINavigationController(rootViewController: v2)
        let nav3 = UINavigationController(rootViewController: v3)
        let nav4 = UINavigationController(rootViewController: v4)
        let nav5 = UINavigationController(rootViewController: v5)
        self.viewControllers = [nav1, nav2, nav3, nav4, nav5]
    }
    
    func edgeInsetCenter(_ center: Bool? = false ) -> UIEdgeInsets {
        return UIEdgeInsets(top: center == true ? -10 : -4, left: 0, bottom: center == true ? 10 : 4, right: 0)
    }
}

enum TabbarValue: String, CaseIterable {
    case chat = "Chat"
    case group = "Groups"
    case home = ""
    case network = "My Network"
    case setting = "Setting"
    
    var image: UIImage {
        switch self {
        case .chat:
            return Asset.ic_tab_chat.image
        case .group:
            return Asset.ic_tab_group.image
        case .home:
            return Asset.ic_tab_sample.image
        case .network:
            return Asset.ic_tab_network.image
        case .setting:
            return Asset.ic_tab_setting.image
        }
    }
    
}

