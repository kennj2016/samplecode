//
//  APICountry.swift
//  sample
//
//  Created by KenNguyen 26/10/2021.
//

import Foundation
struct APICountry {
    static func findCountry(with requestModel:CountryRequest) ->Endpoint<CountryResponse> {
        return Endpoint(path: "api/auth/country/find-country", method: .post, queryParametersEncodable: requestModel)
    }
    static func allCountry() ->Endpoint<[CountryResponse.CountryDTO]> {
        return Endpoint(path: "api/auth/country/country", method: .get)
    }
}
