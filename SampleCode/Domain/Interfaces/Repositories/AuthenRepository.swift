//
//  AuthenRepository.swift
//  sample
//
//  Created by KenNguyen 15/10/2021.
//

import Foundation

protocol AuthenRepository {
    @discardableResult
    func signIn(request: SigInRequest,loadding : Bool,completion: @escaping CompletionHandle) -> Cancellable?
    func getOTP(request: OtpRequest,loadding : Bool,completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable?
    func confirmOTP(request: ConfirmOtpRequest,loadding : Bool,completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable?
    func resetPassword(request: ResetPasswordRequest,loadding : Bool,completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable?
    func signUp(request: SignUpRequest,loadding : Bool,completion: @escaping CompletionHandle) -> Cancellable?
    func profile(loadding : Bool,completion: @escaping CompletionProfileHandle) -> Cancellable?
    func updateProfile(request: UpdateProfileRequest,loadding : Bool,completion: @escaping CompletionProfileHandle) -> Cancellable?

}
