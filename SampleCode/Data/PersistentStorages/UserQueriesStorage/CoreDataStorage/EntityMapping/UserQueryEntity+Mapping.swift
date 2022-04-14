//
//  MovieQueryEntity+Mapping.swift
//  SampleCode
//
//  Created by  KenNguyen on 10.10.21.
//

import Foundation
import CoreData

extension UserQueryEntity {
    convenience init(movieQuery: UserQuery, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        query = movieQuery.query
        createdAt = Date()
    }
}

extension UserQueryEntity {
    func toDomain() -> UserQuery {
        return .init(query: query ?? "")
    }
}
