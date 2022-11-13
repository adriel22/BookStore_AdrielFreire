//
//  NetworkService.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 13/11/22.
//

import Foundation
protocol NetworkService {
    var baseURL: String {get}
    var path: String {get}
    var requestType: RequestType {get}
    var parameters: [String: String]? {get}
}

