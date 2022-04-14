//
//  SignInSignUpVC.swift
//  sample
//
//  Created by KenNguyen 12/10/2021.
//

import UIKit
import Bond
class SignInSignUpVC: BaseHiddenNavigationViewController {
    var appFlowCoordinator: AppFlowCoordinator?
    let appDIContainer = AppDIContainer()

    @IBOutlet weak var imgViewLogo: UIImageView!
    @IBOutlet weak var lbSlogan: UILabel!
    @IBOutlet weak var lbConent: UILabel!
    @IBOutlet weak var btnSignUp: CustomButton!
    @IBOutlet weak var btnSignIn: CustomButton!{
        didSet {
            btnSignIn.isValidButton = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setValueLanguage()

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnSignIn
            .reactive
            .tap
            .observeNext {  _ in
                SHARE_APPLICATION_DELEGATE.appFlowCoordinator!.gotoSignIn()
            }.dispose(in: bag)
    }
    
    private func setValueLanguage() {
        imgViewLogo.image = Asset.login_ic_bg.image
        lbSlogan.text = "Half the World".localized()
        lbConent.text = "Dr. NEE - ID-verified chat application, for safe communication".localized()
        btnSignUp.setAtrributeString(nomarlString: "Not have an account yet".localized() + "?", highlightString: "Sign Up".localized())
        btnSignIn.setTitle("Sign In".localized(), for: .normal)

    }

}
