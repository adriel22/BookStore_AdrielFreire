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

public class Volume: NSObject, NSCoding, Codable {
    
    let id: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
    
    init(id: String, volumeInfo: VolumeInfo, saleInfo: SaleInfo) {
        self.id = id
        self.volumeInfo = volumeInfo
        self.saleInfo = saleInfo
    }
    
    public required init?(coder: NSCoder) {
        id = coder.decodeObject(forKey: "id") as! String
        volumeInfo = coder.decodeObject(forKey: "volumeInfo") as! VolumeInfo
        saleInfo = coder.decodeObject(forKey: "saleInfo") as! SaleInfo
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(volumeInfo, forKey: "volumeInfo")
        coder.encode(saleInfo, forKey: "saleInfo")
    }
}

public class VolumeInfo: NSObject, NSCoding, Codable {
    let title: String
    let bookDescription: String?
    let authors: [String]
    let imageLinks: ImageLinks
    
    init(title: String, description: String?, authors: [String], imageLinks: ImageLinks) {
        self.title = title
        self.bookDescription = description
        self.authors = authors
        self.imageLinks = imageLinks
    }
    
    public required init?(coder: NSCoder) {
        title = coder.decodeObject(forKey: "title") as! String
        bookDescription = coder.decodeObject(forKey: "bookDescription") as? String
        authors = coder.decodeObject(forKey: "authors") as! [String]
        imageLinks = coder.decodeObject(forKey: "imageLinks") as! ImageLinks
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(bookDescription, forKey: "bookDescription")
        coder.encode(authors, forKey: "authors")
        coder.encode(imageLinks, forKey: "imageLinks")
    }
    
    private enum CodingKeys : String, CodingKey {
        case title, bookDescription = "description", authors, imageLinks
    }
}

public class ImageLinks: NSObject, NSCoding, Codable {
    let smallThumbnail: String
    let thumbnail: String
    
    init(smallThumbnail: String, thumbnail: String) {
        self.smallThumbnail = smallThumbnail
        self.thumbnail = thumbnail
    }
    
    public required init?(coder: NSCoder) {
        smallThumbnail = coder.decodeObject(forKey: "smallThumbnail") as! String
        thumbnail = coder.decodeObject(forKey: "thumbnail") as! String
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(smallThumbnail, forKey: "smallThumbnail")
        coder.encode(thumbnail, forKey: "thumbnail")
    }
}

public class SaleInfo: NSObject, NSCoding, Codable {
    let buyLink: String?
    
    init(buyLink: String?) {
        self.buyLink = buyLink
    }
    
    public required init?(coder: NSCoder) {
        buyLink = coder.decodeObject(forKey: "buyLink") as? String
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(buyLink, forKey: "buyLink")
    }
}
