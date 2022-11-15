//
//  BookCollectionViewCell.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 14/11/22.
//

import UIKit
import Kingfisher

protocol BookCollectionViewCellDelegate: AnyObject {
    func bookCollectionViewCell(cell: BookCollectionViewCell, AddedFavorite: Bool)
}

final class BookCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    
    public weak var delegate: BookCollectionViewCellDelegate?
    
    func setup(withImage imageURL: String, isItemSaved: Bool) {
        let url = URL(string: imageURL)
        thumbnailImageView.kf.setImage(with: url)
        
        let buttonImage = isItemSaved ? UIImage(named: "favoritedIcon") : UIImage(named: "addToFavoritesIcon")
        favoriteButton.setImage(buttonImage, for: .normal)
        favoriteButton.isSelected = isItemSaved
    }

    @IBAction func didSelectFavorite(_ sender: Any) {
        favoriteButton.isSelected = !favoriteButton.isSelected
        let buttonImage = favoriteButton.isSelected ? UIImage(named: "favoritedIcon") : UIImage(named: "addToFavoritesIcon")
        favoriteButton.setImage(buttonImage, for: .normal)
        
        delegate?.bookCollectionViewCell(cell: self, AddedFavorite: favoriteButton.isSelected)
    }
}
