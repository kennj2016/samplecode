//
//  DefaultAuthenReponsitory.swift
//  sample
//
//  Created by KenNguyen 15/10/2021.
//

import Foundation
final class DefaultAuthenReponsitory {

    private let dataTransferService: DataTransferService
    private let task = RepositoryTask()

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultAuthenReponsitory: AuthenRepository {
    func updateProfile(request: UpdateProfileRequest, loadding: Bool, completion: @escaping CompletionProfileHandle) -> Cancellable? {
        let endpoint = APIAuthen.updateProfile(with: request)
        task.networkTask = self.dataTransferService.request(with: endpoint, loadding: loadding) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO!.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
    
    func profile(loadding: Bool, completion: @escaping CompletionProfileHandle) -> Cancellable? {
        let endpoint = APIAuthen.profile()
        task.networkTask = self.dataTransferService.request(with: endpoint, loadding: loadding) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO!.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
    
    func signUp(request: SignUpRequest, loadding: Bool, completion: @escaping CompletionHandle) -> Cancellable? {
        let endpoint = APIAuthen.singup(with: request)
        task.networkTask = self.dataTransferService.request(with: endpoint, loadding: loadding) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
    
    func resetPassword(request: ResetPasswordRequest, loadding: Bool, completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable? {
        let endpoint = APIAuthen.resetPassword(with: request)
        task.networkTask = self.dataTransferService.requestString(with: endpoint, loadding: loadding) { result in
            switch result {
            case .success(let responseDTO):
                if responseDTO == "true" {
                    completion(.success(true))
                }else {
                    completion(.success(false))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
    
    func confirmOTP(request: ConfirmOtpRequest, loadding: Bool, completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable? {
        let endpoint = APIAuthen.confirmOTP(with: request)
        task.networkTask = self.dataTransferService.requestString(with: endpoint, loadding: loadding) { result in
            switch result {
            case .success(let responseDTO):
                if responseDTO == "true" {
                    completion(.success(true))
                }else {
                    completion(.success(false))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
    
    func getOTP(request: OtpRequest, loadding: Bool, completion: @escaping (Result<Bool, Error>) -> Void) -> Cancellable? {
        let endpoint = APIAuthen.getOTP(with: request)
        task.networkTask = self.dataTransferService.requestString(with: endpoint, loadding: loadding) { result in
            switch result {
            case .success(let responseDTO):
                if responseDTO == "true" {
                    completion(.success(true))
                }else {
                    completion(.success(false))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
    

    public func signIn(request: SigInRequest,loadding : Bool,completion: @escaping CompletionHandle) -> Cancellable? {
        let endpoint = APIAuthen.signin(with: request)
        task.networkTask = self.dataTransferService.request(with: endpoint, loadding: loadding) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
}
