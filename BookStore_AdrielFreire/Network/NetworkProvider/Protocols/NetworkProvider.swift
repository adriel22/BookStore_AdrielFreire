//
//  NetworkProvider.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 13/11/22.
//

import Foundation
protocol NetworkProvider {
    @discardableResult
    func fetch<T: Codable>(model: T.Type,
                           with configuration: NetworkService,
                           completion: @escaping (Result<T, Error>) -> Void) -> Cancellable
}

