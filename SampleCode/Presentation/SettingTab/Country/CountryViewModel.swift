//
//  CountryViewModel.swift
//  sample
//
//  Created by KenNguyen 26/10/2021.
//

import Foundation

protocol CountryViewModelInput {
    func viewDidLoad()
    func getFindCountry(key: String)
    func getAllCountry()
}

protocol CountryViewModelOutput {
    var error: Observable<String> { get }
    var country: Observable<[CountryModelView]> { get }

}

protocol CountryViewModel: CountryViewModelInput, CountryViewModelOutput {}

final class DefaultCountryViewModel: CountryViewModel {
    
    private let countryUseCase: CountryUseCase
    private var usersLoadTask: Cancellable? { willSet { usersLoadTask?.cancel() } }
    private var page = 0
    private var size = 100

    // MARK: - OUTPUT
    let error: Observable<String> = Observable("")
    var country: Observable<[CountryModelView]> = Observable([])

    // MARK: - Init
    
    init(countryUseCase: CountryUseCase) {
        self.countryUseCase = countryUseCase
    }
    
    // MARK: - Private
    private func allCountry() {
        usersLoadTask = countryUseCase.executeAllCountry(loadding: true, completion: { result in
            switch result {
            case .success(let user):
                print(user)
                self.country.value = user.map({ entity in
                    return CountryModelView.init(model: entity)
                })
                break
            case .failure(let error):
                self.handle(error: error)
            }
            self.usersLoadTask = nil

        })
    }
    
    private func findCountry(requestValue: CountryRequest) {
        usersLoadTask = countryUseCase.executeFindCountry(requestValue: requestValue, loadding: true, completion: { result in
            switch result {
            case .success(let user):
                print(user)
                self.country.value = user.datas.map({ entity in
                    return CountryModelView.init(model: entity)
                })
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

extension DefaultCountryViewModel {
    
    func viewDidLoad() {
        
    }
    
    func getFindCountry(key: String) {
        self.findCountry(requestValue: CountryRequest.init(keyword: key, pageNumber: page, pageSize: size))
    }
    
    func getAllCountry() {
        self.allCountry()
    }

    
}
