//
//  Cancellable.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 13/11/22.
//

import Foundation
protocol Cancellable {
    func cancel()
}

struct EmptyCancellable: Cancellable {
    func cancel() {
    }
}
