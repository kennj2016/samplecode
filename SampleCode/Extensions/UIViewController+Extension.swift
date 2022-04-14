//
//  UIViewControllerExtension.swift
//  SampleCode
//
//  Created by  KenNguyen on 04/06/2021.
//

import UIKit
import Toast_Swift

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)

let IS_IPAD: Bool = (UIDevice.current.userInterfaceIdiom == .pad)
let IS_IPHONE: Bool = (UIDevice.current.userInterfaceIdiom == .phone)
let IS_RETINA: Bool = (UIScreen.main.scale >= 2.0)

let IS_IPHONE_X: Bool = (IS_IPHONE&&(SCREEN_MAX_LENGTH >= 812.0))

extension UIViewController {

    var screenSize: CGRect {
        return UIScreen.main.bounds
    }

    var navigationBarHeight: CGFloat {
        return self.navigationController?.navigationBar.frame.height ?? 0.0
    }
    
    var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
        } else {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
    
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = UIApplication.shared.windows.first else { return }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        if (animated) {
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
    
    func hideNavigationBar(_ animated: Bool = false) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showNavigationBar(_ animated: Bool = false) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func showToastMessage(message: String, _ duration: TimeInterval = 2.0) {
        if message.isEmpty { return }
        
        let screenSize = self.view.bounds.size
        
        let bottomPadding = bottomSafeAreaHeight()
        
        self.view.hideAllToasts()
        self.view.makeToast(message, duration: duration, point: CGPoint(x: screenSize.width / 2, y: screenSize.height - bottomPadding - 100.asDesigned), title: nil, image: nil, completion: nil)
    }
    
    func topSafeAreaHeight() -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
            return safeFrame.minY
        }
        
        return 0.0
    }
    
    func bottomSafeAreaHeight() -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
            return window.frame.maxY - safeFrame.maxY
        }
        
        return 0.0
    }

    func presentPopUpFullScreen(_ viewController: UIViewController,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: animated, completion: completion)
    }
    
}
