//
//  UIApplicationExtension.swift
//  SampleCode
//
//  Created by  KenNguyen on 12/06/2021.
//

import UIKit

extension UIApplication {
    
    func getKeyWindow() -> UIWindow? {
        guard let window = UIApplication.shared.keyWindow else { return nil }
        return window
    }
    
}
