//
//  MainCoordinator.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 13/11/22.
//

import UIKit
final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator]?
    var navigationController: UINavigationController
    private let windowScene: UIWindowScene
    private var window: UIWindow?
    private let homeViewModel = HomeViewModel(DefaultNetworkProvider())
    
    init(withScene windowScene: UIWindowScene) {
        let viewController = HomeViewController(homeViewModel)
        navigationController = UINavigationController(rootViewController: viewController)
        self.windowScene = windowScene
    }
    
    func start() {
        homeViewModel.coordinatorDelegate = self
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

extension MainCoordinator: HomeViewModelCoordinatorDelegate {
    func homeViewModel(_ viewModel: HomeViewModel, didSelectVolume volume: Volume) {
        let detailsCoordinator = BookDetailsCoordinator(navigationController, bookVolume: volume)
        detailsCoordinator.start()
    }
}
