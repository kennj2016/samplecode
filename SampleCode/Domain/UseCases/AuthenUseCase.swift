//
//  AuthenUseCase.swift
//  sample
//
//  Created by KenNguyen 15/10/2021.
//

import Foundation
protocol AuthenUseCase {
    func executeSignUp(requestValue: SignUpRequest,loadding: Bool,
                 completion: @escaping CompletionHandle) -> Cancellable?
    func executeSignIn(requestValue: SigInRequest,loadding: Bool,
                 completion: @escaping CompletionHandle) -> Cancellable?
    func executeOTP(requestValue: OtpRequest,loadding: Bool,
                 completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable?
    func executeConfirmOTP(requestValue: ConfirmOtpRequest,loadding: Bool,
                 completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable?
    func executeResetPassword(requestValue: ResetPasswordRequest,loadding: Bool,
                 completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable?
    func executeProfile(loadding: Bool,
                 completion: @escaping CompletionProfileHandle) -> Cancellable?

    func executeUpdateProfile(request: UpdateProfileRequest,loadding: Bool,
                 completion: @escaping CompletionProfileHandle) -> Cancellable?


}

final class DefaultAuthenUseCase: AuthenUseCase {
  
    private let authenRepository: AuthenRepository

    init(authenRepository: AuthenRepository,
         authenQueriesRepository: AuthenQueriesRepository) {
        self.authenRepository = authenRepository
    }
    
    func executeProfile(loadding: Bool, completion: @escaping CompletionProfileHandle) -> Cancellable? {
        return authenRepository.profile(loadding: loadding) { result in
            completion(result)
        }
    }
    
    func executeUpdateProfile(request: UpdateProfileRequest, loadding: Bool, completion: @escaping CompletionProfileHandle) -> Cancellable? {
        return authenRepository.updateProfile(request: request, loadding: loadding) { result in
            completion(result)
        }
    }

    
    func executeResetPassword(requestValue: ResetPasswordRequest, loadding: Bool, completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable? {
        return authenRepository.resetPassword(request: requestValue, loadding: loadding) { result in
            completion(result)
        }
    }
    
    func executeOTP(requestValue: OtpRequest, loadding: Bool, completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable? {
        return authenRepository.getOTP(request: requestValue, loadding: loadding) { result in
            completion(result)
        }
    }
    
    func executeConfirmOTP(requestValue: ConfirmOtpRequest, loadding: Bool, completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable? {
        return authenRepository.confirmOTP(request: requestValue, loadding: loadding) { result in
            completion(result)
        }
    }
    
    
    func executeSignUp(requestValue: SignUpRequest, loadding: Bool, completion: @escaping CompletionHandle) -> Cancellable? {
        return authenRepository.signUp(request: requestValue, loadding: loadding) { result in
            completion(result)
        }
    }

    func executeSignIn(requestValue: SigInRequest,loadding: Bool,
                 completion: @escaping CompletionHandle) -> Cancellable? {
        return authenRepository.signIn(request: requestValue, loadding: loadding) { result in
            switch result {
            case .success(let user):
                if let accessToken = user.accessToken {
                    //Save token
                    AppConfiguration.setToken(join: accessToken)
                    
                }
            case .failure(_):
                break
            }
            completion(result)
        }
    }
}
