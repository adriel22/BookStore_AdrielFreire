//
//  NetworkMockProvider.swift
//  BookStore_AdrielFreireTests
//
//  Created by Adriel Freire on 14/11/22.
//

import Foundation
@testable import BookStore_AdrielFreire

final class NetworkMockProvider<T>: NetworkProvider {
    var expectedResult: T
    let requestSuccess: Bool
    init(_ expectedResult: T, requestSuccess: Bool) {
        self.expectedResult = expectedResult
        self.requestSuccess = requestSuccess
    }
    func fetch<T>(model: T.Type, with configuration: BookStore_AdrielFreire.NetworkService, completion: @escaping (Result<T, Error>) -> Void) -> BookStore_AdrielFreire.Cancellable where T : Decodable, T : Encodable {
        if requestSuccess {
            completion(.success(expectedResult as! T))
        } else {
            completion(.failure(NSError(domain: "Error", code: 0)))
        }
        return EmptyCancellable()
    }
    
    
}
