//
//  ProfileUseCase.swift
//  sample
//
//  Created by KenNguyen 25/10/2021.
//

import Foundation
protocol SmileUseCase {
  
}

final class DefaultProfileUseCase: SmileUseCase {
  
    private let smileRepository: SmileRepository

    init(smileRepository: SmileRepository,
         smileQueriesRepository: SmileQueriesRepository) {
        self.smileRepository = smileRepository
    }
    
    
}
