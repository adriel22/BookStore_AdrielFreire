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
    
    init(withScene windowScene: UIWindowScene) {
        let homeViewModel = HomeViewModel()
        let viewController = HomeViewController(homeViewModel)
        navigationController = UINavigationController(rootViewController: viewController)
        self.windowScene = windowScene
//        homeViewModel.coordinatorDelegate = self
    }
    
    func start() {
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
