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
                                  content: volume.volumeInfo.bookDescription ?? ""))
        details.append(BookDetail(title: "Authors",
                                  content: getAuthorsString()))
        
        return details
    }
    
    func getSaleLink() -> String? {
        volume.saleInfo.buyLink
    }
    
    private func getAuthorsString() -> String{
        var authors = ""
        volume.volumeInfo.authors.forEach { author in
            authors += "\(author), "
        }
        
        authors = String(authors.dropLast(2))
        return authors
    }
    
    func didSelectFavotire() {
        if isItemSaved() {
            CoreDataManager.shared.remove(volume)
            return
        }
        CoreDataManager.shared.save(volume)
    }
    
    func isItemSaved() -> Bool{
        let volumes = CoreDataManager.shared.retrieveSavedVolumes()
        return volumes.contains(where: {$0.id == volume.id})
    }
}
