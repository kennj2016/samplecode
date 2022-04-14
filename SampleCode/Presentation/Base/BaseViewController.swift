//
//  BaseViewController.swift
//  sample
//
//  Created by KenNguyen 11/10/2021.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         self.navigationController?.isNavigationBarHidden = false
     }

}


class BaseHiddenNavigationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         self.navigationController?.isNavigationBarHidden = false
     }
    
 
}
