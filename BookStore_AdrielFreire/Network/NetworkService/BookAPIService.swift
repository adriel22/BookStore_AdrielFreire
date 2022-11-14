//
//  BookAPIService.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 13/11/22.
//

import Foundation
enum BookAPIService {
    case getBooks(Int)
    
    private func getParamethers() -> [String: String] {
        switch self {
        case .getBooks(let page):
            var paramethes = [String : String]()
            paramethes["q"] = "ios"
            paramethes["maxResults"] = String(Constants.maxResults)
            paramethes["startIndex"] = String(Constants.maxResults * page)
            return paramethes
        }
    }
}

extension BookAPIService: NetworkService {
    var baseURL: String {
        switch self {
        case .getBooks: return "https://www.googleapis.com"
        }
    }
    
    var path: String {
        switch self {
        case .getBooks: return "/books/v1/volumes"
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .getBooks: return .get
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .getBooks: return getParamethers()
        }
    }
    
    
}

fileprivate struct Constants {
    static let maxResults = 20
}
