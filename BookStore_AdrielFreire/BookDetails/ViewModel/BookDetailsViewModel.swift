//
//  BookDetailsViewModel.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 15/11/22.
//

import Foundation
final class BookDetailsViewModel {
    private let volume: Volume
    
    init(_ volume: Volume) {
        self.volume = volume
    }
    
    func getThumbnailPath() -> String {
        volume.volumeInfo.imageLinks.thumbnail
    }
}
