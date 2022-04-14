//
//  EditProfileVC.swift
//  sample
//
//  Created by KenNguyen 22/10/2021.
//

import UIKit

class EditProfileVC: CustomPickerNavibarProfile {
    //MARK: IBOUTLETS
    @IBOutlet weak var tfNickName: TextFieldDr! {
        didSet {
            tfNickName.textFieldType = .normal_no_icon
            tfNickName.placeHolder = "Nickname".localized()
        }
    }
    @IBOutlet weak var tfFullName: TextFieldDr! {
        didSet {
            tfFullName.textFieldType = .normal_no_icon
            tfFullName.placeHolder = "Full name".localized()
        }
    }
    @IBOutlet weak var tfBOD: TextFieldDr! {
        didSet {
            tfBOD.textFieldType = .bod
            tfBOD.placeHolder = "MM/DD/YYYY".localized()
        }
    }
    
    @IBOutlet weak var tfEmail: TextFieldDr! {
        didSet {
            tfEmail.isUserInteractionEnabled = false
            tfEmail.textFieldType = .normal_no_icon
            tfEmail.placeHolder = "Email".localized()
        }
    }
    
    @IBOutlet weak var tfPhoneNumber: TextFieldDr! {
        didSet {
            tfNickName.textFieldType = .normal_no_icon
            tfPhoneNumber.placeHolder = "Phone number".localized()
            tfPhoneNumber.keyboardType = .phonePad
        }
    }
    
    @IBOutlet weak var tfPrePhone: TextFieldDr! {
        didSet {
            tfPrePhone.keyboardType = .phonePad
        }
    }
    
    @IBOutlet weak var lbGender: UILabel! {
        didSet {
            lbGender.text = "Gender".localized()
        }
    }
    
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    
    @IBOutlet weak var tfNational: TextFieldDr!{
        didSet {
            tfNational.textFieldType = .custom
            tfNational.placeHolder = "National".localized()
        }
    }
    
    @IBOutlet weak var tfMarriedStatus: TextFieldDr!{
        didSet {
            tfMarriedStatus.textFieldType = .custom
            tfMarriedStatus.placeHolder = "Married Status".localized()
        }
    }
    
    @IBOutlet weak var btnSave: CustomButton! {
        didSet {
            btnSave.setTitle("Save".localized(), for: .normal)
        }
    }
    
    @IBOutlet weak var lbError: UILabel!{
        didSet {
            lbError.isHidden = true
        }
    }
    
    //MARK: OTHER VARIABLES

    private var viewModel:AuthenViewModel!
    private var bodSelected: Date? {
        didSet {
            guard let date = bodSelected else {
                return
            }
            self.tfBOD.text = date.dateToString(DateFormat.DATE_APP_FORMAT.rawValue)
        }
    }
    private var marriedStatus: MaritalStatus? {
        didSet {
            guard let stauts = marriedStatus else {
                return
            }
            self.tfMarriedStatus.text = stauts.textValue.capitalizingFirstLetter()
        }
    }
    private var isGender:UserGender = .MALE {
        didSet {
            btnMale.setImage(isGender == .MALE ? Asset.profile_selected.image : Asset.profile_un_select.image, for: .normal)
            btnFemale.setImage(isGender != .MALE ? Asset.profile_selected.image : Asset.profile_un_select.image, for: .normal)
        }
    }
    
    private var isValidNickName = false {
        didSet {
            btnSave.isValidButton = isValidNickName && isValidFullName && isValidPhone
            tfNickName.isCheckValid = isValidNickName
        }
    }
    
    
    private var isValidFullName = false {
        didSet {
            btnSave.isValidButton = isValidNickName && isValidFullName && isValidPhone
            tfFullName.isCheckValid = isValidFullName
        }
    }
    
    
    private var isValidPhone = false {
        didSet {
            btnSave.isValidButton = isValidNickName && isValidFullName && isValidPhone
            tfPhoneNumber.isCheckValid = isValidPhone
        }
    }
    private var country: CountryModelView? {
        didSet {
            tfNational.text = country?.name
        }
    }
    //MARK: VIEW LIFE CYCLE
    static func create(with viewModel: AuthenViewModel) -> EditProfileVC {
        let view = EditProfileVC()
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
        self.navigationTitle = "Edit Info".localized()
        self.isRoundTopLeftRight = true
        self.isGender = .MALE
        // Sign in button
        btnMale
            .reactive
            .tap
            .observeNext { [weak self] _ in
                guard let `self` = self else { return }
                `self`.isGender = .MALE
            }.dispose(in: bag)
        
        btnFemale
            .reactive
            .tap
            .observeNext { [weak self] _ in
                guard let `self` = self else { return }
                `self`.isGender = .FEMALE
            }.dispose(in: bag)
        
        btnSave
            .reactive
            .tap
            .observeNext { [weak self] _ in
                guard let `self` = self else { return }
                `self`.updateProfile()
            }.dispose(in: bag)
    }
    
    private func setupDebugs() {
        
    }
    
    //MARK: - HANDLE EVENT & BIND VIEWMODLE
    func handleEvent() {
        tfBOD.beginCallBack = {
            self.showDatePicker(origin: self.view) { item in
                self.bodSelected = item
            }
            self.view.endEditing(true)
        }
        
        tfNational.beginCallBack = {
            let vc = SHARE_APPLICATION_DELEGATE.appFlowCoordinator?.flow.countryVC()
            vc?.callBack = {(value) in
                guard let country = value as? CountryModelView else {
                    return
                }
                self.country = country
            }
            self.navigationController?.pushViewController(vc!, animated: true)
            self.view.endEditing(true)
        }
        
        tfMarriedStatus.beginCallBack = {
            self.showInforPicker(items: MaritalStatus.allCases.map({$0.textValue.capitalizingFirstLetter()})) { item, index in
                guard let index = index else {
                    return
                }
                self.marriedStatus = MaritalStatus.allCases[index]
            }
            self.view.endEditing(true)
        }
        
        
        self.isValidNickName = ValidationManager.shared.isValidUserName(username: tfNickName.value ?? "")
        tfNickName.typingCallBack = {(value) in
            self.isValidNickName = ValidationManager.shared.isValidUserName(username: value)
        }
        
        self.isValidFullName = ValidationManager.shared.isValidUserName(username: tfFullName.value ?? "")
        tfFullName.typingCallBack = {(value) in
            self.isValidFullName = ValidationManager.shared.isValidUserName(username: value)
        }
        
        self.isValidPhone = ValidationManager.shared.isValidPhoneNumber(phone: tfPhoneNumber.value ?? "")
        tfPhoneNumber.typingCallBack = {(value) in
            self.isValidPhone = ValidationManager.shared.isValidPhoneNumber(phone: value)
        }
        
    }
    
    private func bind(to viewModel: AuthenViewModel) {
        viewModel.error.observe(on: self) { [weak self] in self?.errorMessage($0) }
    }
    
    private func setValueLanguage() {
        
    }
    
    
    // MARK: API SERVICE
    private func updateProfile() {
        hideKeyboard()
        viewModel.updateProfile(nickname: tfNickName.value ?? "", phone: tfPhoneNumber.value ?? "", fullname: tfFullName.value ?? "", birthDay: (self.bodSelected?.dateToString(DateFormat.DATE_APP_FORMAT.rawValue))!, gender: self.isGender, countryCode: tfNational.value ?? "", maritalStatus: self.marriedStatus ?? .SINGLE)
    }
    
    // MARK: OBSERVE & ACTION
    private func errorMessage(_ error: String) {
        guard !error.isEmpty else { return }
        self.lbError.isHidden = false
        self.lbError.text = error
    }


}
