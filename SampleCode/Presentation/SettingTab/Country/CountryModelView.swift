//
//  CountryModelView.swift
//  sample
//
//  Created by KenNguyen 26/10/2021.
//

import Foundation
struct CountryModelView: Equatable {
    let code: String
    let name: String
}

extension CountryModelView {
    init(model: CountryEntity) {
        self.code = model.code ?? ""
        self.name = model.nationality ?? ""
    }
}
