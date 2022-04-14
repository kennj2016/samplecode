//
//  DataTransfer.swift
//  SampleCode
//
//  Created by  KenNguyen on 10.10.21

import Foundation

public enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
    case api(Any)
}

public protocol DataTransferService {
    typealias CompletionHandler<T> = (Result<T, DataTransferError>) -> Void

    @discardableResult
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E,loadding: Bool,
                                                       completion: @escaping CompletionHandler<T>) -> NetworkCancellable? where E.Response == T
    @discardableResult
    func requestString<E: ResponseRequestable>(with endpoint: E,loadding: Bool,
                                                              completion: @escaping CompletionHandler<String>) -> NetworkCancellable? where E.Response == String
//    @discardableResult
//    func request<E: ResponseRequestable>(with endpoint: E,loadding: Bool,
//                                         completion: @escaping CompletionHandler<Void>) -> NetworkCancellable? where E.Response == Void
}

public protocol DataTransferErrorResolver {
    func resolve(error: NetworkError) -> Error
}

public protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

public protocol DataTransferErrorLogger {
    func log(error: Error)
}

public final class DefaultDataTransferService {
    
    private let networkService: NetworkService
    private let errorResolver: DataTransferErrorResolver
    private let errorLogger: DataTransferErrorLogger
    
    public init(with networkService: NetworkService,
                errorResolver: DataTransferErrorResolver = DefaultDataTransferErrorResolver(),
                errorLogger: DataTransferErrorLogger = DefaultDataTransferErrorLogger()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
        self.errorLogger = errorLogger
    }
}

extension DefaultDataTransferService: DataTransferService {
    
    public func request<T: Decodable, E: ResponseRequestable>(with endpoint: E,loadding: Bool,
                                                              completion: @escaping CompletionHandler<T>) -> NetworkCancellable? where E.Response == T {
       
        return self.networkService.request(endpoint: endpoint, loading: loadding) { result in
            switch result {
            case .success(let data):
                let errorModel = self.decodeNormal(data: data, decoder: endpoint.responseDecoder)
                if let error = errorModel?.error {
                    DispatchQueue.main.async { return completion(.failure(.api(error.toDomain()))) }
                }else {
                    let resultMain: Result<T, DataTransferError> = self.decode(data: data, decoder: endpoint.responseDecoder)
                    DispatchQueue.main.async { return completion(resultMain) }
                }
                
            case .failure(let error):
                self.errorLogger.log(error: error)
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async { return completion(.failure(error)) }
            }
        }
    }
    
    public func requestString<E: ResponseRequestable>(with endpoint: E,loadding: Bool,
                                                              completion: @escaping CompletionHandler<String>) -> NetworkCancellable? where E.Response == String {

        return self.networkService.request(endpoint: endpoint, loading: loadding) { result in
            switch result {
            case .success(let data):
                let result: Result<String, DataTransferError> = self.decodeToString(data: data)
                DispatchQueue.main.async { return completion(result) }
            case .failure(let error):
                self.errorLogger.log(error: error)
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async { return completion(.failure(error)) }
            }
        }
    }

//    public func request<E>(with endpoint: E,loadding: Bool, completion: @escaping CompletionHandler<Void>) -> NetworkCancellable? where E : ResponseRequestable, E.Response == Void {
//        return self.networkService.request(endpoint: endpoint, loading: loadding) { result in
//            switch result {
//            case .success:
//                DispatchQueue.main.async { return completion(.success(())) }
//            case .failure(let error):
//                self.errorLogger.log(error: error)
//                let error = self.resolve(networkError: error)
//                DispatchQueue.main.async { return completion(.failure(error)) }
//            }
//        }
//    }

    // MARK: - Private
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder) -> Result<T, DataTransferError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            self.errorLogger.log(error: error)
            return .failure(.parsing(error))
        }
    }
    
    private func decodeNormal(data: Data?, decoder: ResponseDecoder) -> ErrorModel? {
        guard let data = data, let result: ErrorModel = try? decoder.decode(data) else { return nil}
        return result
    }
    
    private func decodeToString(data: Data?) -> Result<String, DataTransferError> {
        guard let data = data else { return .failure(.noResponse) }
        let str = String(decoding: data, as: UTF8.self)
        return .success(str)
    }
    
    private func resolve(networkError error: NetworkError) -> DataTransferError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }

}

// MARK: - Logger
public final class DefaultDataTransferErrorLogger: DataTransferErrorLogger {
    public init() { }
    
    public func log(error: Error) {
        printIfDebug("-------------")
        printIfDebug("\(error)")
    }
}

// MARK: - Error Resolver
public class DefaultDataTransferErrorResolver: DataTransferErrorResolver {
    public init() { }
    public func resolve(error: NetworkError) -> Error {
        return error
    }
}

// MARK: - Response Decoders
public class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    public init() { }
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

public class RawDataResponseDecoder: ResponseDecoder {
    public init() { }
    
    enum CodingKeys: String, CodingKey {
        case `default` = ""
    }
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        if T.self is Data.Type, let data = data as? T {
            return data
        } else {
            let context = DecodingError.Context(codingPath: [CodingKeys.default], debugDescription: "Expected Data type")
            throw Swift.DecodingError.typeMismatch(T.self, context)
        }
    }
}
