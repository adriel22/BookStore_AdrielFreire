//
//  HomeViewController.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 13/11/22.
//

import UIKit

final class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    @IBOutlet private weak var booksCollectionView: UICollectionView!
    
    private var isShowingOnlySaveds = false
    
    init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

// MARK: - Life Cycle Methods
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        booksCollectionView.reloadData()
    }
}

// MARK: - Auxiliar Methods
extension HomeViewController {
    private func initialSetup() {
        booksCollectionView.registerCell(type: BookCollectionViewCell.self)
        booksCollectionView.dataSource = self
        booksCollectionView.delegate = self
        
        viewModel.delegate = self
        viewModel.requestVolumes()
        
        setupNavigationBar()
    }
    
    private func getCellSize() -> CGSize {
        let collectionWidth = UIScreen.main.bounds.width
        let cellWidth = (collectionWidth / 2) - (2 * Constants.cellPadding)
        let cellHeight = 2 * cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    private func setupNavigationBar() {
        let itemTitle = isShowingOnlySaveds ? "Show all" : "Show favorites"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: itemTitle, style: .plain, target: self, action: #selector(toggleShowFavoritesOnly))
    }
    
    @objc private func toggleShowFavoritesOnly() {
        isShowingOnlySaveds = !isShowingOnlySaveds
        let itemTitle = isShowingOnlySaveds ? "Show all" : "Show favorites"
        navigationItem.rightBarButtonItem?.title = itemTitle
        booksCollectionView.reloadData()
    }
}

// MARK: - Collection Methods
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNumberOfVolumes(isShowingOnlySaveds)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeue(withType: BookCollectionViewCell.self, for: indexPath) { cell in
            let volume = self.viewModel.getVolume(forPosition: indexPath.item, showingFavorites: self.isShowingOnlySaveds)
            let thumbnail = volume.volumeInfo.imageLinks.thumbnail
            let isItemSaved = self.viewModel.isItemSaved(itemPosition: indexPath.item, showingFavorites: self.isShowingOnlySaveds)
            cell.setup(withImage: thumbnail, isItemSaved: isItemSaved)
            cell.delegate = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getCellSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constants.cellPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,
                            left: Constants.cellPadding,
                            bottom: 0,
                            right: Constants.cellPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.getNumberOfVolumes(isShowingOnlySaveds) - 5 {
            viewModel.requestVolumes()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(inPosition: indexPath.item, showingFavorites: isShowingOnlySaveds)
    }
}

// MARK: - Cell Delegate
extension HomeViewController: BookCollectionViewCellDelegate {
    func bookCollectionViewCell(cell: BookCollectionViewCell, AddedFavorite: Bool) {
        if let index = booksCollectionView.indexPath(for: cell) {
            viewModel.didSelectFavotireItem(inPosition: index.item, showingFavorites: isShowingOnlySaveds)
        }
    }
    
}


// MARK: - ViewModel Binding
extension HomeViewController: HomeViewModelDelegate {
    func homeViewModel(_ homeViewModel: HomeViewModel, didUpdateVolumes volumes: [Volume]) {
        DispatchQueue.main.async {
            self.booksCollectionView.reloadData()            
        }
    }
    
    
}


fileprivate struct Constants {
    static let cellPadding: CGFloat = 16
}
