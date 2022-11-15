//
//  BookCollectionViewCell.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 14/11/22.
//

import UIKit
import Kingfisher

final class BookCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    
    func setup(withImage imageURL: String) {
        let url = URL(string: imageURL)
        thumbnailImageView.kf.setImage(with: url)
    }

}
