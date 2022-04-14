//
//  SignVC.swift
//  SampleCode
//
//  Created by KenNguyen 04/10/2021.
//

import UIKit

class SignInVC: CustomNavigationBarViewController {
    //MARK: IBOUTLETS
    @IBOutlet weak var imgViewLogo: UIImageView!
    @IBOutlet weak var btnSignIn: CustomButton!
    @IBOutlet weak var btnForgotPassword: CustomButton!
    @IBOutlet weak var btnSignUp: CustomButton!
    @IBOutlet weak var tfEmail: TextFieldDr!{
        didSet {
            tfEmail.backgroundColor = ColorDr.blue_30_alpha.value
        }
    }
    @IBOutlet weak var tfPassword: TextFieldDr!{
        didSet {
            tfPassword.textFieldType = .password
            tfPassword.backgroundColor = ColorDr.blue_30_alpha.value
        }
    }
    @IBOutlet weak var btnEng: CustomButton!
    @IBOutlet weak var btnViet: CustomButton!
    @IBOutlet weak var lbError: UILabel!{
        didSet {
            lbError.isHidden = true
        }
    }
    //MARK: OTHER VARIABLES
    private var viewModel:AuthenViewModel!
    private let appDIContainer = AppDIContainer()
    private var appFlowCoordinator: AppFlowCoordinator?
    private var isValidUsername = false {
        didSet {
            lbError.isHidden = true
            btnSignIn.isValidButton = isValidUsername && isValidPassword
        }
    }
    
    private var isValidPassword = false{
        didSet {
            lbError.isHidden = true
            btnSignIn.isValidButton = isValidUsername && isValidPassword
        }
    }
    
    //MARK: VIEW LIFE CYCLE
    static func create(with viewModel: AuthenViewModel) -> SignInVC {
        let view = SignInVC()
        view.viewModel = viewModel
        return view
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
        //Show legal
        isHasRightButton = true

        //Language value
        setValueLanguage()
        
        // Sign in button
        btnSignIn
            .reactive
            .tap
            .observeNext { [weak self] _ in
                guard let `self` = self else { return }
                self.signIn()
            }.dispose(in: bag)
        
        // Sign up button
        btnSignUp
            .reactive
            .tap
            .observeNext { [weak self] _ in
                guard let `self` = self else { return }
                self.hideKeyboard()
                self.navigationController?.pushViewController(SignUpVC.create(with: self.viewModel), animated: true)
            }.dispose(in: bag)
        
        // Forgot password button
        btnForgotPassword
            .reactive
            .tap
            .observeNext { [weak self] _ in
                guard let `self` = self else { return }
                self.hideKeyboard()
                self.navigationController?.pushViewController(ForgotPasswordStep1VC.create(with: self.viewModel), animated: true)
            }.dispose(in: bag)
        
        // Language
        btnEng
            .reactive
            .tap
            .observeNext { [weak self] _ in
                guard let `self` = self else { return }
                self.hideKeyboard()
                LanguageManager.shared.currentLanguage = .en
                `self`.setValueLanguage()
            }.dispose(in: bag)
        btnViet
            .reactive
            .tap
            .observeNext { [weak self] _ in
                guard let `self` = self else { return }
                self.hideKeyboard()
                LanguageManager.shared.currentLanguage = .vi
                `self`.setValueLanguage()
                
            }.dispose(in: bag)
        
    }
    
    private func setupDebugs() {
        
    }
    
    //MARK: - HANDLE EVENT & BIND VIEWMODLE
    func handleEvent() {
        self.isValidUsername = ValidationManager.shared.isValidUserName(username: tfEmail.value ?? "")
        
        tfEmail.typingCallBack = {(value) in
            self.isValidUsername = ValidationManager.shared.isValidUserName(username: value)
        }
        self.isValidPassword = ValidationManager.shared.isValidPassword(pass: tfPassword.value ?? "")
        
        tfPassword.typingCallBack = {(value) in
            self.isValidPassword = ValidationManager.shared.isValidPassword(pass: value)
        }
    }
    
    private func bind(to viewModel: AuthenViewModel) {
        viewModel.error.observe(on: self) { [weak self] in self?.errorMessage($0) }
    }
    
    private func setValueLanguage() {
        imgViewLogo.image = Asset.login_ic_logo.image
        btnSignIn.setTitle("Sign In".localized(), for: .normal)
        btnForgotPassword.setTitle(nomarlString: "Forgot Password".localized() + "?", titleColor: ColorDr.gray_text.value)
        btnSignUp.setAtrributeString(nomarlString: "Not have an account yet".localized() + "?", highlightString: "Sign Up".localized())
        tfEmail.placeHolder = "Email or Username".localized()
        tfPassword.placeHolder = "Password".localized()
        btnEng.setTitle(nomarlString: "English".localized(), titleColor: LanguageManager.shared.currentLanguage != .vi ? ColorDr.blue.value : ColorDr.gray_text.value)
        btnViet.setTitle(nomarlString: "Tiếng Việt".localized(), titleColor: LanguageManager.shared.currentLanguage == .vi ? ColorDr.blue.value : ColorDr.gray_text.value)
        lbError.text = "Username or password is incorrect".localized()
        
    }
    
    // MARK: API SERVICE
    private func signIn() {
        hideKeyboard()
        viewModel.signIn(email: tfEmail.value ?? "", password: tfPassword.value ?? "")
    }
    
    // MARK: OBSERVE & ACTION
    private func errorMessage(_ error: String) {
        guard !error.isEmpty else { return }
        self.lbError.isHidden = false
    }

    
}

