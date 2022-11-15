//
//  BookDetailsViewController.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 15/11/22.
//

import UIKit
import Kingfisher

final class BookDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailsTableView: UITableView!
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
        setupTable()
    }
}

// MARK: - Auxiliar Methods
extension BookDetailsViewController {
    private func setupThumbnail() {
        let imageURL = URL(string: viewModel.getThumbnailPath())
        thumbnailImageView.kf.setImage(with: imageURL)
    }
    
    private func setupTable() {
        detailsTableView.dataSource = self
        detailsTableView.registerCell(type: MovieDetailTableViewCell.self)
    }
}

// MARK: - TableView Methods
extension BookDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getVolumeDetails().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueCell(withType: MovieDetailTableViewCell.self, for: indexPath) { cell in
            let detail = self.viewModel.getVolumeDetails()[indexPath.item]
            cell.setup(withTitle: detail.title, content: detail.content)
        }
    }
    
    
}
