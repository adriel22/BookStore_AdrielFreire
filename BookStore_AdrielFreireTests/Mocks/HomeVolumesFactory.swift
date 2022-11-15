//
//  HomeVolumesFactory.swift
//  BookStore_AdrielFreireTests
//
//  Created by Adriel Freire on 14/11/22.
//

import Foundation
@testable import BookStore_AdrielFreire

struct HomeVolumesFactory {
    
    func build(page: Int = 0) -> VolumesDTO {
        VolumesDTO(items: buildPage(page))
    }
    
    private func buildPage(_ pageNumber: Int) -> [Volume] {
        let volume1 = Volume(volumeInfo: buildVolumeInfo(withTitle: "page\(pageNumber) volume1"), saleInfo: SaleInfo(buyLink: "TestLink"))
        let volume2 = Volume(volumeInfo: buildVolumeInfo(withTitle: "page\(pageNumber) volume2"), saleInfo: SaleInfo(buyLink: nil))
        
        return [volume1, volume2]
    }
    
    
    private func buildVolumeInfo(withTitle tile: String) -> VolumeInfo {
        VolumeInfo(title: tile,
                   description: "Test Volume",
                   authors: ["Jhon", "Anna", "Maria"],
                   imageLinks: ImageLinks(smallThumbnail: "smallThumbnailTest", thumbnail: "ThumbnailTest"))
    }
    
}
