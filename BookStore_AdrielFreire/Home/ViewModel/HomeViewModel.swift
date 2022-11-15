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
    
    func getNumberOfVolumes() -> Int {
        return volumes.count
    }
    
    func getVolume(forPosition position: Int) -> Volume {
        return volumes[position]
    }
    
    func didSelectItem(inPosition position: Int) {
        coordinatorDelegate?.homeViewModel(self, didSelectVolume: volumes[position])
    }
}

