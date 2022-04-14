//
//  ProfileVC.swift
//  sample
//
//  Created by KenNguyen 22/10/2021.
//

import UIKit

class ProfileVC: CustomNavibarProfile {

    //MARK: IBOUTLETS
    
    @IBOutlet weak var imgViewCover: UIImageView!
    @IBOutlet weak var imgViewAvatar: UIImageView!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var viewVeried: UIView!
    @IBOutlet weak var lbVerified: UILabel! {
        didSet {
            lbVerified.text = "Verified".localized()
        }
    }
    
    @IBOutlet weak var viewActiveLeader: UIView!
    
    @IBOutlet weak var lbActiveLeader: UILabel! {
        didSet {
            lbActiveLeader.text = "Active Leader".localized()

        }
    }
    @IBOutlet weak var viewReject: UIView!
    @IBOutlet weak var imgViewReject: UIImageView!
    @IBOutlet weak var imgViewRejectNext: UIImageView!
    @IBOutlet weak var lbReject: UILabel!
    
    
    @IBOutlet weak var btnVerifyNow: CustomButton!{
        didSet {
            btnVerifyNow.setTitleButtonLine(string: "Verify Now".localized(), color: ColorDr.blue.value,backgroundColor: nil)

        }
    }
    @IBOutlet weak var btnFullInfor: CustomButton!{
        didSet {
            btnFullInfor.setTitleButtonLine(string: "View Full Information".localized(), color: ColorDr.blue.value,backgroundColor: ColorDr.blue.value)
        }
    }
    @IBOutlet weak var viewFullInfor: UIStackView!
    @IBOutlet weak var lbNumberFriend: UILabel!
    @IBOutlet weak var lbFriend: UILabel! {
        didSet {
            lbFriend.text = "Friends".localized()

        }
    }
    
    @IBOutlet weak var lbNumberSmiles: UILabel!
    @IBOutlet weak var lbSmiles: UILabel!{
        didSet {
            lbSmiles.text = "Smiles".localized()
        }
    }
    
    @IBOutlet weak var lbNumberFollows: UILabel!
    @IBOutlet weak var lbFollows: UILabel!{
        didSet {
            lbFollows.text = "Follows".localized()
        }
    }
    
    @IBOutlet weak var lbPointTitle: UILabel!{
        didSet {
            lbPointTitle.text = "Score".localized()
        }
    }
    @IBOutlet weak var lbPoint: UILabel!

    
    @IBOutlet weak var lbInformation: UILabel! {
        didSet {
            lbInformation.text = "Information".localized()
        }
    }
    
    @IBOutlet weak var lbAlertInforVerified: UILabel! {
        didSet {
            lbAlertInforVerified.text = "(\("Thông tin dưới đây đã được xác thực".localized()))"
        }
    }
    @IBOutlet weak var viewInforVerified: UIView!
    @IBOutlet weak var btnEditInfor: UIButton!
    
    @IBOutlet weak var lbFullNameTitle: UILabel!{
        didSet {
            lbFullNameTitle.text = "Full Name".localized()
        }
    }
    @IBOutlet weak var lbFullName: UILabel!

    @IBOutlet weak var lbBODTitle: UILabel!{
        didSet {
            lbBODTitle.text = "BOD".localized()
        }
    }
    @IBOutlet weak var lbBOD: UILabel!

    
    @IBOutlet weak var lbGenderTitle: UILabel!{
        didSet {
            lbGenderTitle.text = "Gender".localized()
        }
    }
    @IBOutlet weak var lbGender: UILabel!

    
    @IBOutlet weak var lbNationalTitle: UILabel!{
        didSet {
            lbNationalTitle.text = "National".localized()
        }
    }
    @IBOutlet weak var lbNational: UILabel!

    
    @IBOutlet weak var lbMarriedStatusTitle: UILabel!{
        didSet {
            lbMarriedStatusTitle.text = "Married Status".localized()
        }
    }
    @IBOutlet weak var lbMarriedStatus: UILabel!
    
    //MARK: OTHER VARIABLES
    private var viewModel:AuthenViewModel!
    
    //MARK: VIEW LIFE CYCLE
    static func create(with viewModel: AuthenViewModel) -> ProfileVC {
        let view = ProfileVC()
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
        self.navigationTitle = "Profile".localized()
        self.isHasRightProfileButton = true
    
        //Reset KYC
        resetUI()
        
        // Edit
        btnEditInfor
            .reactive
            .tap
            .observeNext { [weak self] _ in
                guard let `self` = self else { return }
                `self`.navigationController?.pushViewController(EditProfileVC.create(with: self.viewModel), animated: true)
            }.dispose(in: bag)
    }
    
    private func setupDebugs() {
        
    }
    
    //MARK: - HANDLE EVENT & BIND VIEWMODLE
    func handleEvent() {
        self.didTapQrButton = {
            print("qr")
            self.navigationController?.pushViewController(QRCodeVC(), animated: true)

        }
        
        self.didTapCameraButton = {
            print("camera")
        }
    }
    
    private func bind(to viewModel: AuthenViewModel) {
        viewModel.error.observe(on: self) { [weak self] in self?.errorMessage($0) }
        viewModel.profileModel.observe(on: self) { profile in
            guard let profile = profile else {
                return
            }
            self.fillData(profile: profile)
        }
        self.profile()
    }
    
    private func setValueLanguage() {
        
    }
    
    private func fillData(profile: ProfileViewModel) {
        lbName.text = profile.username
        lbGender.text = profile.gender
        lbBOD.text = profile.bod
        lbPoint.text = "\(profile.reputationRating)"
        lbNational.text = profile.national
        lbUsername.text = profile.nickName
        imgViewAvatar.kfImageURL(profile.avatar, placeHolder: Asset.setting_avatar_default.image)
        imgViewCover.kfImageURL(profile.cover, placeHolder: Asset.profile_cover_default.image)
        lbMarriedStatus.text = profile.marriedStatus
        lbFullName.text = profile.fullName
        lbNumberSmiles.text = "\(profile.totalSmile)"
        lbNumberFollows.text = "\(profile.totalFollower)"
        lbNumberFriend.text = "\(0)"

        
        viewActiveLeader.isHidden = !profile.isActiveLeader
        
        switch profile.kycStatus {
        case .NOT_VERIFY:
            btnVerifyNow.isHidden = false
        case .VERIFIED:
            viewInforVerified.isHidden = false
            viewFullInfor.isHidden = false
            lbAlertInforVerified.isHidden = false
            viewVeried.isHidden = false

        case .REVIEWING:
            btnVerifyNow.isHidden = false
            viewReject.isHidden = false
            imgViewRejectNext.image = Asset.setting_next.image.tintImageColor(with: ColorDr.blue.value)
            lbReject.textColor = ColorDr.blue.value
            lbReject.text = profile.kycStatus.textValue
            imgViewReject.image = Asset.profile_verify.image.tintImageColor(with: ColorDr.blue.value)

        case .REJECTED: // reject
            btnVerifyNow.isHidden = false
            viewReject.isHidden = false
            imgViewRejectNext.image = Asset.setting_next.image.tintImageColor(with: ColorDr.red_text.value)
            lbReject.textColor = ColorDr.red_text.value
            lbReject.text = profile.kycStatus.textValue
            imgViewReject.image = Asset.profile_verify.image.tintImageColor(with: ColorDr.red_text.value)
            
        default:
            self.resetUI()
        }
        
    }
    
    private func resetUI() {
        viewVeried.isHidden = true
        viewReject.isHidden = true
        viewFullInfor.isHidden = true
        viewInforVerified.isHidden = true
        btnVerifyNow.isHidden = true
        lbAlertInforVerified.isHidden = true
    }
    
    
    // MARK: API SERVICE
    private func profile() {
        self.viewModel.getProfile()
    }
    
    // MARK: OBSERVE & ACTION
    private func errorMessage(_ error: String) {
        guard !error.isEmpty else { return }
//        self.lbError.isHidden = false
    }

}
