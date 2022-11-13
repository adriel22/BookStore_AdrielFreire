//
//  DefaultNetworkProvider.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 13/11/22.
//

import Foundation
struct DefaultNetworkProvider: NetworkProvider {
    func fetch<T>(model: T.Type, with configuration: NetworkService, completion: @escaping (Result<T, Error>) -> Void) -> Cancellable where T : Decodable, T : Encodable {
        
        guard var urlComponents = URLComponents(string: configuration.baseURL) else {
            let error = NSError(domain: "Invalid endpoint", code: 400)
            completion(.failure(error))
            return EmptyCancellable()
        }
        
        urlComponents.path = configuration.path
        urlComponents.queryItems = []
        if let parameters = configuration.parameters {
            parameters.forEach { parameter in
                urlComponents.queryItems?.append(URLQueryItem(name: parameter.key, value: parameter.value))
            }
        }
        
        guard let url = urlComponents.url else {
            let error = NSError(domain: "Invalid endpoint", code: 400)
            completion(.failure(error))
            return EmptyCancellable()
        }
        var request = URLRequest(url: url)
        request.httpMethod = configuration.requestType.rawValue
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let data = data else {
                return completion(.failure(NSError()))
            }
            
            if let response = response as? HTTPURLResponse, !(200 ..< 300 ~= response.statusCode) {
                let data = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let message = data?["status_message"] as? String
                return completion(.failure(NSError(domain: message ?? "unknow", code: response.statusCode)))
            }

            
            do {
                let object = try JSONDecoder().decode(model, from: data)
                completion(.success(object))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
        
        task.resume()
        return task
    }
}
