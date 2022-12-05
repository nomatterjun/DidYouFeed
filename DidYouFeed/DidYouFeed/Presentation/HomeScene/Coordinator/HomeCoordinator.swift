//
//  File.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/05.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    // MARK: - Properties
    
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var homeViewController: HomeViewController
    
    // MARK: - Initializer
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.homeViewController = HomeViewController()
    }
    
    // MARK: - Functions
    
    func start() {
        self.homeViewController.reactor = HomeViewModel(
            coordinator: self
        )
        self.navigationController.pushViewController(
            self.homeViewController,
            animated: true
        )
    }
    
    func finish() {
        self.parentCoordinator?.childCoordinatorDidFinish(self)
    }
}
