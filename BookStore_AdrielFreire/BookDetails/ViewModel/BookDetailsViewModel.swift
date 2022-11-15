//
//  BookDetailsViewModel.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 15/11/22.
//

import Foundation
final class BookDetailsViewModel {
    private let volume: Volume
    
    typealias BookDetail = (title: String, content: String)
    
    init(_ volume: Volume) {
        self.volume = volume
    }
    
    func getThumbnailPath() -> String {
        volume.volumeInfo.imageLinks.thumbnail
    }
    
    func getVolumeDetails() -> [BookDetail] {
        var details = [BookDetail]()
        details.append(BookDetail(title: "Title:", content:
                                    volume.volumeInfo.title))
        details.append(BookDetail(title: "Description:",
                                  content: volume.volumeInfo.description ?? ""))
        details.append(BookDetail(title: "Authors",
                                  content: getAuthorsString()))
        
        return details
    }
    
    private func getAuthorsString() -> String{
        var authors = ""
        volume.volumeInfo.authors.forEach { author in
            authors += "\(author), "
        }
        
        authors = String(authors.dropLast(2))
        return authors
    }
}
