//
//  ForgotPasswordStep1VC.swift
//  SampleCode
//
//  Created by KenNguyen 04/10/2021.
//

import UIKit

class ForgotPasswordStep1VC: CustomNavigationBarViewController {

    //MARK: IBOUTLETS
    @IBOutlet weak var imgViewLogo: UIImageView! {
        didSet {
            imgViewLogo.image = Asset.forgot_pass_logo.image
        }
    }
    
    @IBOutlet weak var lbTitle: UILabel! {
        didSet {
            lbTitle.text = "Forgot Password".localized() + "?"
        }
    }
    
    @IBOutlet weak var tfEmail: TextFieldDr!{
        didSet {
            tfEmail.isHiddenRightIcon = true
            tfEmail.placeHolder = "Email or Username".localized()
            tfEmail.backgroundColor = ColorDr.blue_30_alpha.value
        }
    }
    
    @IBOutlet weak var btnNext: CustomButton! {
        didSet {
            btnNext.setTitle("Verify".localized(), for: .normal)
        }
    }
    
    @IBOutlet weak var lbError: UILabel!{
        didSet {
            lbError.isHidden = true
            lbError.text = "Wrong username or email".localized()
        }
    }
   
    //MARK: OTHER VARIABLES
    private var isValidUsername = false {
        didSet {
            btnNext.isValidButton = isValidUsername
            lbError.isHidden = true
            tfEmail.isCheckValid = isValidUsername
        }
    }
    private var viewModel:AuthenViewModel!

    //MARK: VIEW LIFE CYCLE
    static func create(with viewModel: AuthenViewModel) -> ForgotPasswordStep1VC {
        let view = ForgotPasswordStep1VC()
        view.viewModel = viewModel
        return view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            setupViews()
            setupDebugs()
            handleEvent()
            bind(to: viewModel)
    }
    
    //MARK: - SETUP VIEW
    private func setupViews() {
        btnNext
            .reactive
            .tap
            .observeNext { [weak self] _ in
                guard let `self` = self else { return }
                self.getOtp()
            }.dispose(in: bag)
    }
    
    private func setupDebugs() {

    }
    
    //MARK: - HANDLE EVENT & BIND VIEWMODLE
    private func handleEvent() {
        self.isValidUsername = ValidationManager.shared.isValidUserName(username: tfEmail.value ?? "")
        tfEmail.typingCallBack = {(value) in
            self.isValidUsername = ValidationManager.shared.isValidUserName(username: value)
        }
    }
    
    private func bind(to viewModel: AuthenViewModel) {
        viewModel.viewDidLoad()
        viewModel.getOTP.observe(on: self) { success in
            guard let success = success else {
                return
            }
            if success {
                self.gotoStep2()
            }else {
                self.errorMessage()
            }
        }
    }
    
    // MARK: API SERVICE
    private func getOtp() {
        hideKeyboard()
        viewModel.getOtp(email: tfEmail.value ?? "")
    }
    
    // MARK: OBSERVE & ACTION
    private func gotoStep2() {
        self.navigationController?.pushViewController(ForgotPasswordStep2VC.create(with: self.viewModel), animated: true)
    }
    
    private func errorMessage() {
        self.lbError.isHidden = false
        self.tfEmail.isCheckValid = false
    }

}
