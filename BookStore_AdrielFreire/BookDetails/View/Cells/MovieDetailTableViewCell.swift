//
//  MovieDetailTableViewCell.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 15/11/22.
//

import UIKit

final class MovieDetailTableViewCell: UITableViewCell {
    @IBOutlet private weak var contentTitleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(withTitle title: String, content: String) {
        contentTitleLabel.text = title
        contentLabel.text = content
    }
}
