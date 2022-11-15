//
//  HomeVolumesFactory.swift
//  BookStore_AdrielFreireTests
//
//  Created by Adriel Freire on 14/11/22.
//

import Foundation
@testable import BookStore_AdrielFreire

struct HomeVolumesFactory {
    private var volumeInfo: VolumeInfo {
        VolumeInfo(title: "TestInfo",
                   imageLinks: ImageLinks(smallThumbnail: "smallThumbnailTest", thumbnail: "ThumbnailTest"))
    }
    
    func build() -> VolumesDTO {
        let volume1 = Volume(volumeInfo: volumeInfo)
        let volume2 = Volume(volumeInfo: volumeInfo)
        
        let volumes = [volume1, volume1]
        let volumesDTO = VolumesDTO(items: volumes)
        return volumesDTO
    }
    
}
