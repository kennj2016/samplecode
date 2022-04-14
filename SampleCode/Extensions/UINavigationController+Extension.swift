//
//  UINavigationController+Extension.swift
//  SampleCode
//
//  Created by  KenNguyen on 27/09/2021.
//

import UIKit

extension UINavigationController {

    func getViewController<T: UIViewController>(of type: T.Type) -> UIViewController? {
        return self.viewControllers.first(where: { $0 is T })
    }

    func popToViewController<T: UIViewController>(of type: T.Type, animated: Bool = true) {
        guard let viewController = self.getViewController(of: type) else { return }
        self.popToViewController(viewController, animated: animated)
    }

}
