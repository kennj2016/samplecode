//
//  RepositoryTask.swift
//  SampleCode
//
//  Created by  KenNguyen on 25.10.19.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
