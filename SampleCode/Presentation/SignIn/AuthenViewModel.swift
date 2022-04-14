//
//  SignInViewModel.swift
//  SampleCode
//
//  Created by  KenNguyen on 02/10/2021.
//

import FirebaseMessaging
struct AuthenViewModelActions {
    let gotoMainApp: (UserEntity) -> Void
}

enum AuthenViewModelLoading {
    case fullScreen
    case nextPage
}

protocol AuthenViewModelInput {
    func viewDidLoad()
    func signIn(email: String, password: String)
    func getOtp(email: String)
    func confirmOtp(code: String)
    func resetPassword(pass: String)
    func signUp(username: String, email: String, password: String)
    func getProfile()
    func updateProfile(nickname: String, phone: String, fullname: String, birthDay: String, gender: UserGender, countryCode: String, maritalStatus: MaritalStatus)


}

protocol AuthenViewModelOutput {
    var error: Observable<String> { get }
    var errorTitle: String { get }
    var getOTP: Observable<Bool?> { get }
    var confirmOTP: Observable<Bool?> { get }
    var resetPassword: Observable<Bool?> { get }
    var signUpSucces: Observable<Bool?> { get }
    var profileModel: Observable<ProfileViewModel?> { get }

}

protocol AuthenViewModel: AuthenViewModelInput, AuthenViewModelOutput {}

final class DefaultAuthenViewModel: AuthenViewModel {
  
    private let authenUseCase: AuthenUseCase
    private let actions: AuthenViewModelActions?
    private var usersLoadTask: Cancellable? { willSet { usersLoadTask?.cancel() } }
    private var email = ""
    private var code = ""
    private var pass = ""

    // MARK: - OUTPUT
    let error: Observable<String> = Observable("")
    let errorTitle = NSLocalizedString("Error", comment: "")
    var getOTP: Observable<Bool?> = Observable(nil)
    var confirmOTP: Observable<Bool?> = Observable(nil)
    var resetPassword: Observable<Bool?> = Observable(nil)
    var signUpSucces: Observable<Bool?> = Observable(nil)
    var profileModel: Observable<ProfileViewModel?> = Observable(nil)

    // MARK: - Init
    
    init(authenUseCase: AuthenUseCase,
         actions: AuthenViewModelActions? = nil) {
        self.authenUseCase = authenUseCase
        self.actions = actions
    }
    

    // MARK: - Private
    private func signIn(requestValue: SigInRequest) {
        usersLoadTask = authenUseCase.executeSignIn(requestValue: requestValue, loadding: true, completion: { result in
            switch result {
            case .success(let user):
                print(user)
                SHARE_APPLICATION_DELEGATE.appFlowCoordinator?.start()
                break
            case .failure(let error):
                self.handle(error: error)
            }
            self.usersLoadTask = nil

        })
    }
    
    private func signUp(requestValue: SignUpRequest) {
        usersLoadTask = authenUseCase.executeSignUp(requestValue: requestValue, loadding: true, completion: { result in
            switch result {
            case .success(let user):
                print(user)
                SHARE_APPLICATION_DELEGATE.appFlowCoordinator?.start()
                break
            case .failure(let error):
                self.handle(error: error)
            }
            self.usersLoadTask = nil

        })
    }
    
    
    private func getOTP(requestValue: OtpRequest) {
        
        usersLoadTask = authenUseCase.executeOTP(requestValue: requestValue, loadding: true, completion: { result in
            switch result {
            case .success(let success):
                self.getOTP.value = success
            case .failure:
                self.getOTP.value = false
            }
            self.usersLoadTask = nil

        })
    }
    
    private func confirmOTP(requestValue: ConfirmOtpRequest) {
        usersLoadTask = authenUseCase.executeConfirmOTP(requestValue: requestValue, loadding: true, completion: { result in
            switch result {
            case .success(let success):
                self.confirmOTP.value = success
            case .failure:
                self.confirmOTP.value = false
            }
            self.usersLoadTask = nil
        })
    }
    
    private func resetPassword(requestValue: ResetPasswordRequest) {
        usersLoadTask = authenUseCase.executeResetPassword(requestValue: requestValue, loadding: true, completion: { result in
            switch result {
            case .success(let success):
                self.resetPassword.value = success
            case .failure:
                self.resetPassword.value = false
            }
            self.usersLoadTask = nil

        })
    }
    
    private func updateProfile(requestValue: UpdateProfileRequest) {
        usersLoadTask = authenUseCase.executeUpdateProfile(request: requestValue, loadding: true, completion: { result in
            switch result {
            case .success(let success):
                self.profileModel.value = ProfileViewModel.init(user: success)
            case .failure(let error):
                self.handle(error: error)
            }
            self.usersLoadTask = nil

        })
    }
    
    private func profile() {
        usersLoadTask = authenUseCase.executeProfile(loadding: true, completion: { result in
            switch result {
            case .success(let success):
//                self.resetPassword.value = success
                self.profileModel.value = ProfileViewModel.init(user: success)
                break
            case .failure(let error):
                self.handle(error: error)
            }
            self.usersLoadTask = nil

        })
    }
    
    private func handle(error: DataTransferError) {

        switch error {
        case .api(let api):
            if let api = api as? ErrorEntity {
                self.error.value = api.message ?? ""
            }
        default:
            self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading User", comment: "")
        }
        
    }
}

// MARK: - INPUT. View event methods

extension DefaultAuthenViewModel {
    
    func viewDidLoad() {
    }
    
    func signUp(username: String, email: String, password: String) {
        self.signUp(requestValue: SignUpRequest(username: username, email: email, password: password, deviceToken: Messaging.messaging().fcmToken ?? ""))
    }
    
    func signIn(email: String, password: String) {
        self.signIn(requestValue: SigInRequest(username: email, password: password, deviceToken: Messaging.messaging().fcmToken ?? ""))
    }
    
    func getOtp(email: String) {
        if email.isEmpty == false {
            self.email = email
        }
        self.getOTP(requestValue: OtpRequest(userName: self.email))
    }
    
    func confirmOtp(code: String) {
        self.code = code
        self.confirmOTP(requestValue: ConfirmOtpRequest(userName: self.email,code: code))
    }
    
    func resetPassword(pass: String) {
        self.pass = pass
        self.resetPassword(requestValue: ResetPasswordRequest(userName: self.email,code: self.code,password: pass))
    }
    
    func getProfile() {
        self.profile()
    }
    
    func updateProfile(nickname: String, phone: String, fullname: String, birthDay: String, gender: UserGender, countryCode: String, maritalStatus: MaritalStatus) {
        self.updateProfile(requestValue: UpdateProfileRequest(nickname: nickname, phone: phone, fullname: fullname, birthDay: birthDay, gender: gender.rawValue, countryCode: countryCode, maritalStatus: maritalStatus.rawValue))
    }

    
}
