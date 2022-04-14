//
//  File.swift
//  sample
//
//  Created by KenNguyen 15/10/2021.
//

import Foundation
protocol AuthenQueriesRepository {
    func saveToken(query: SigInRequestABCCCCC, completion: @escaping CompletionHandle)
}
