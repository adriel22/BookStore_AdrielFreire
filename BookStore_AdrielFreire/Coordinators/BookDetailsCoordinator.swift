//
//  BookDetailsCoordinator.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 15/11/22.
//

import UIKit
final class BookDetailsCoordinator: Coordinator {
    var childCoordinators: [Coordinator]?
    
    var navigationController: UINavigationController
    private let bookVolume: Volume
    
    init(_ navigationController: UINavigationController, bookVolume: Volume) {
        self.navigationController = navigationController
        self.bookVolume = bookVolume
    }
    
    func start() {
        let viewModel = BookDetailsViewModel(bookVolume)
        let viewController = BookDetailsViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    
}
