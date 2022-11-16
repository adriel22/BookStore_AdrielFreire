//
//  HomeViewModel.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 13/11/22.
//

import Foundation
protocol HomeViewModelDelegate: AnyObject {
    func homeViewModel(_ homeViewModel: HomeViewModel, didUpdateVolumes volumes: [Volume])
}

protocol HomeViewModelCoordinatorDelegate: AnyObject {
    func homeViewModel(_ viewModel: HomeViewModel, didSelectVolume volume: Volume)
}

final class HomeViewModel {
    public weak var delegate: HomeViewModelDelegate?
    public weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    private let networkProvider: NetworkProvider
    private var pageRequest = 0
    private var isRequestInProcess = false
    
    private var volumes = [Volume]() {
        didSet {
            delegate?.homeViewModel(self, didUpdateVolumes: volumes)
        }
    }
    
    init(_ networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    func requestVolumes() {
        if isRequestInProcess {
            return
        }
        
        isRequestInProcess = true
        
        networkProvider.fetch(model: VolumesDTO.self, with: BookAPIService.getBooks(pageRequest)) { result in
            switch result {
            case .success(let volumes):
                self.volumes.append(contentsOf: volumes.items)
                self.pageRequest += 1
            case .failure(let error):
                debugPrint(error)
            }
            self.isRequestInProcess = false
        }
    }
    
    func getNumberOfVolumes(_ showingFavorites: Bool) -> Int {
        if showingFavorites {
            return CoreDataManager.shared.retrieveSavedVolumes().count
        }
        return volumes.count
    }
    
    func getVolume(forPosition position: Int, showingFavorites: Bool) -> Volume {
        if showingFavorites {
            return CoreDataManager.shared.retrieveSavedVolumes()[position]
        }
        return volumes[position]
    }
    
    func didSelectItem(inPosition position: Int, showingFavorites: Bool) {
        if showingFavorites {
            let volume = CoreDataManager.shared.retrieveSavedVolumes()[position]
            coordinatorDelegate?.homeViewModel(self, didSelectVolume: volume)
            return
        }
        coordinatorDelegate?.homeViewModel(self, didSelectVolume: volumes[position])
    }
    
    func didSelectFavotireItem(inPosition position: Int, showingFavorites: Bool) {
        if isItemSaved(itemPosition: position, showingFavorites: showingFavorites) {
            let volume = showingFavorites ? CoreDataManager.shared.retrieveSavedVolumes() : volumes
            CoreDataManager.shared.remove(volume[position])
            return
        }
        CoreDataManager.shared.save(volumes[position])
    }
    
    func isItemSaved(itemPosition: Int, showingFavorites: Bool) -> Bool{
        let savedVolumes = CoreDataManager.shared.retrieveSavedVolumes()
        if showingFavorites {
            let volume = savedVolumes[itemPosition]
            return savedVolumes.contains(where: {$0.id == volume.id})
        }
        let volume = volumes[itemPosition]
        return savedVolumes.contains(where: {$0.id == volume.id})
    }
}

