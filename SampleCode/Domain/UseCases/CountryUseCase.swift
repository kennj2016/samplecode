//
//  CountryUseCase.swift
//  sample
//
//  Created by KenNguyen 26/10/2021.
//

import Foundation
protocol CountryUseCase {
    func executeFindCountry(requestValue: CountryRequest,loadding: Bool,
                 completion: @escaping CompletionCountryFindHandle) -> Cancellable?
    func executeAllCountry(loadding: Bool,
                 completion: @escaping CompletionCountryHandle) -> Cancellable?
  


}

final class DefaultCountryUseCase: CountryUseCase {
    private let countryRepository: CountryRepository
    init(countryRepository: CountryRepository,
         countryQueriesRepository: CountryQueriesRepository) {
        self.countryRepository = countryRepository
    }
    
    func executeFindCountry(requestValue: CountryRequest, loadding: Bool, completion: @escaping CompletionCountryFindHandle) -> Cancellable? {
        countryRepository.findCountry(request: requestValue, loadding: loadding) { result in
            completion(result)
        }
    }
    
    func executeAllCountry(loadding: Bool, completion: @escaping CompletionCountryHandle) -> Cancellable? {
        countryRepository.allCountry(loadding: loadding) { result in
            switch result {
            case .success(let country):
                //Save all country
                break
            case .failure(_):
                break
            }
            completion(result)
        }

    }
}
