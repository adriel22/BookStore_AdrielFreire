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
final class HomeViewModel {
    public weak var delegate: HomeViewModelDelegate?
    private let networkProvider: NetworkProvider
    private var pageRequest = 0
    
    private var volumes = [Volume]() {
        didSet {
            delegate?.homeViewModel(self, didUpdateVolumes: volumes)
        }
    }
    
    init(_ networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    func requestVolumes() {
        networkProvider.fetch(model: VolumesDTO.self, with: BookAPIService.getBooks(pageRequest)) { result in
            switch result {
            case .success(let volumes):
                self.volumes = volumes.items
                self.pageRequest += 1
            case .failure(let error):
                print("error")
            }
        }
    }
    
    func getNumberOfVolumes() -> Int {
        return volumes.count
    }
    
    func getVolume(forPosition position: Int) -> Volume {
        return volumes[position]
    }
}

