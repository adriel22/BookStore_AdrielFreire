//
//  BookDetailsViewController.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 15/11/22.
//

import UIKit
import Kingfisher

final class BookDetailsViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    private let viewModel: BookDetailsViewModel
    
    init(viewModel: BookDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "BookDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

// MARK: - Life Cycle Methods
extension BookDetailsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupThumbnail()
    }
}

// MARK: - Auxiliar Methods
extension BookDetailsViewController {
    private func setupThumbnail() {
        let imageURL = URL(string: viewModel.getThumbnailPath())
        thumbnailImageView.kf.setImage(with: imageURL)
    }
}
