//
//  CountryRepostory.swift
//  sample
//
//  Created by KenNguyen 26/10/2021.
//

import Foundation
protocol CountryRepository {
    @discardableResult
    func findCountry(request: CountryRequest,loadding : Bool,completion: @escaping CompletionCountryFindHandle) -> Cancellable?
    func allCountry(loadding : Bool,completion: @escaping CompletionCountryHandle) -> Cancellable?

}
