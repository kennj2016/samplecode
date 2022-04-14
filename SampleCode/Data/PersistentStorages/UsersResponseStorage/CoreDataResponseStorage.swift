//
//  CoreDataResponseStorage.swift
//  SampleCode
//
//  Created by  KenNguyen on 05/04/2020.
//

import Foundation
import CoreData

final class CoreDataResponseStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: - Private

    private func fetchRequest(for requestDto: RequestModel) -> NSFetchRequest<UserRequestEntity> {
        let request: NSFetchRequest = UserRequestEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@ AND %K = %d",
                                        #keyPath(UserRequestEntity.query), requestDto.query,
                                        #keyPath(UserRequestEntity.page), requestDto.page)
        return request
    }

    private func deleteResponse(for requestDto: RequestModel, in context: NSManagedObjectContext) {
        let request = fetchRequest(for: requestDto)

        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }
}

extension CoreDataResponseStorage: UserResponseStorage {

    func getResponse(for requestDto: RequestModel, completion: @escaping (Result<UserResponse?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = self.fetchRequest(for: requestDto)
                let requestEntity = try context.fetch(fetchRequest).first
//                completion(.success(requestEntity?.response?.toDTO()))

//                completion(.success(requestEntity?.response?.toDTO()))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }

    func save(response responseDto: UserResponse, for requestDto: RequestModel) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteResponse(for: requestDto, in: context)

                let requestEntity = requestDto.toEntity(in: context)
                requestEntity.response = responseDto.toEntity(in: context)

                try context.save()
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}
