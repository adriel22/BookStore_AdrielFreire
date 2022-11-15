//
//  BookModel.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 13/11/22.
//

import Foundation
struct BookModel: Codable {
    let kind: String
}

struct VolumesDTO: Codable {
    let items: [Volume]
}

struct Volume: Codable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let description: String?
    let authors: [String]
    let imageLinks: ImageLinks
}

struct ImageLinks: Codable {
    let smallThumbnail: String
    let thumbnail: String
}
