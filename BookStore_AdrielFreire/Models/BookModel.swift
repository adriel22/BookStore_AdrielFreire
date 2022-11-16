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
    
    let id: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
}

public class VolumeInfo: NSObject, NSCoding, Codable {
    let title: String
    let bookDescrption: String?
    let authors: [String]
    let imageLinks: ImageLinks
    
    private enum CodingKeys : String, CodingKey {
        case title, bookDescrption = "description", authors, imageLinks
    }
    
    public required init?(coder: NSCoder) {
        title = coder.decodeObject(forKey: "title") as! String
        bookDescrption = coder.decodeObject(forKey: "bookDescrption") as? String
        authors = coder.decodeObject(forKey: "authors") as! [String]
        imageLinks = coder.decodeObject(forKey: "imageLinks") as! ImageLinks
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(bookDescrption, forKey: "bookDescrption")
        coder.encode(authors, forKey: "authors")
        coder.encode(imageLinks, forKey: "imageLinks")
    }
}

public class ImageLinks: NSObject, NSCoding, Codable {
    let smallThumbnail: String
    let thumbnail: String
    
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
    
    public required init?(coder: NSCoder) {
        buyLink = coder.decodeObject(forKey: "buyLink") as? String
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(buyLink, forKey: "buyLink")
    }
}
