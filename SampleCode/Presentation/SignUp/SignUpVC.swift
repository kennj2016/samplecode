//
//  SignUpVC.swift
//  SampleCode
//
//  Created by KenNguyen 04/10/2021.
//

import UIKit
class SignUpVC: CustomNavigationBarViewController {

    //MARK: IBOUTLETS
    @IBOutlet weak var imgViewLogo: UIImageView!
    @IBOutlet weak var viewEmailValid: UIView!
    @IBOutlet weak var lbEmailValid: UILabel!
    @IBOutlet weak var tfUserName: TextFieldDr! {
        didSet {
            tfUserName.backgroundColor = ColorDr.blue_30_alpha.value
        }
    }
    @IBOutlet weak var viewUserNameValid: UIView!
    @IBOutlet weak var lbUserNameSuggestion1: UILabel!
    @IBOutlet weak var lbUserNameSuggestion2: UILabel!
    @IBOutlet weak var viewPasswordValid: UIView!
    @IBOutlet weak var lbPassValid: UILabel!
    @IBOutlet weak var btnCapcha: UIButton!
    @IBOutlet weak var lbProtectCapcha: UILabel!
    @IBOutlet weak var lbTerm: UILabel!
    @IBOutlet weak var btnSignIn: CustomButton!
    @IBOutlet weak var btnSignUp: UIButton!
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
    private var isValidEmail = false {
        didSet {
            viewEmailValid.isHidden = isValidEmail
            tfEmail.isCheckValid = isValidEmail
        }
    }
    private var isValidUserName = false {
        didSet {
            viewUserNameValid.isHidden = isValidUserName
            tfUserName.isCheckValid = isValidUserName

        }
    }
    private var isValidPass = false {
        didSet {
            viewPasswordValid.isHidden = isValidPass
        }
    }
    private var viewModel:AuthenViewModel!

    //MARK: VIEW LIFE CYCLE
    static func create(with viewModel: AuthenViewModel) -> SignUpVC {
        let view = SignUpVC()
        view.viewModel = viewModel
        return view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setValueLanguage()
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
        // show legal
        isHasRightButton = true
        
        //Language value
        setValueLanguage()

        // Sign in button
        btnSignIn
            .reactive
            .tap
            .observeNext { [weak self] _ in
                guard let `self` = self else { return }
                `self`.navigationController?.popViewController(animated: true)
            }.dispose(in: bag)
        
        // Sign up button
        btnSignUp
            .reactive
            .tap
            .observeNext { [weak self] _ in
                guard let `self` = self else { return }
                `self`.signUp()
            }.dispose(in: bag)
        
        // Language
        btnEng
            .reactive
            .tap
            .observeNext { [weak self] _ in
                guard let `self` = self else { return }
                LanguageManager.shared.currentLanguage = .en
                `self`.setValueLanguage()
            }.dispose(in: bag)
        btnViet
            .reactive
            .tap
            .observeNext { [weak self] _ in
                guard let `self` = self else { return }
                LanguageManager.shared.currentLanguage = .vi
                `self`.setValueLanguage()

            }.dispose(in: bag)
        
    }
    
    private func setupDebugs() {}
   
    //MARK: - HANDLE EVENT & BIND VIEWMODLE

    func handleEvent() {
        
        self.isValidEmail = ValidationManager.shared.isValidEmail(email: tfEmail.value ?? "")

        tfEmail.typingCallBack = {(value) in
            self.isValidEmail = ValidationManager.shared.isValidEmail(email: value)
        }
        
        self.isValidUserName = ValidationManager.shared.isValidUserName(username: tfUserName.value ?? "")
        tfUserName.typingCallBack = {(value) in
            self.isValidUserName = ValidationManager.shared.isValidUserName(username: value)
        }
        
        self.isValidPass = ValidationManager.shared.isValidPassword(pass: tfPassword.value ?? "")
        tfPassword.typingCallBack = {(value) in
            self.isValidPass = ValidationManager.shared.isValidPassword(pass: value)
        }
    }
    
    
    private func bind(to viewModel: AuthenViewModel) {
        viewModel.error.observe(on: self) { [weak self] in self?.errorMessage($0) }
    }
    
  
    
    private func setValueLanguage() {
        imgViewLogo.image = Asset.login_ic_logo.image
        lbEmailValid.text = "We highly recommend you use truly email in case that forgot password".localized()
        tfUserName.placeHolder = "User name".localized()
        lbUserNameSuggestion1.text = "trang.nguyen123".localized()
        lbUserNameSuggestion2.text = "trang.nguyen555".localized()
        lbPassValid.text = "Have a better using security password than 123456, abc123,...".localized()
        btnSignIn.setAtrributeString(nomarlString: "Already have any account".localized() + "?", highlightString: "Sign In".localized())
        btnSignUp.setTitle("Sign Up".localized(), for: .normal)
        tfEmail.placeHolder = "Email".localized()
        tfPassword.placeHolder = "Password".localized()
        btnEng.setTitle(nomarlString: "English".localized(), titleColor: LanguageManager.shared.currentLanguage != .vi ? ColorDr.blue.value : ColorDr.gray_text.value)
        btnViet.setTitle(nomarlString: "Tiếng Việt".localized(), titleColor: LanguageManager.shared.currentLanguage == .vi ? ColorDr.blue.value : ColorDr.gray_text.value)
        lbError.text = "Wrong username or email".localized()

    }
    
    // MARK: API SERVICE
    private func signUp() {
        hideKeyboard()
        viewModel.signUp(username: tfUserName.value ?? "", email: tfEmail.value ?? "", password: tfPassword.value ?? "")
    }
    // MARK: OBSERVE & ACTION
    
    private func errorMessage(_ error: String) {
        guard !error.isEmpty else { return }
        self.lbError.isHidden = false
    }
}
