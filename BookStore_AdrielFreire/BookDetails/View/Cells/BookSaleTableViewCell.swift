//
//  MovieSaleTableViewCell.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 15/11/22.
//

import UIKit

class BookSaleTableViewCell: UITableViewCell {

    @IBOutlet weak var saleButton: UIButton!
    private var buttonLink = ""
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(withSaleLink link: String) {
        saleButton.setTitle(link, for: .normal)
        buttonLink = link
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        if let url = URL(string: buttonLink) {
            UIApplication.shared.open(url)
        }
    }
    
}
