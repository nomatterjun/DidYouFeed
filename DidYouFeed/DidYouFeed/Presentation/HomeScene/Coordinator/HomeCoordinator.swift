//
//  File.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/05.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    // MARK: - Properties
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType = .home
    
    // MARK: - Initializer
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Functions
    
    func start() {
        let homeViewModel = HomeViewReactor(coordinator: self)
        let homeViewController = HomeViewController(reactor: homeViewModel)
        self.navigationController.pushViewController(
            homeViewController,
            animated: true
        )
    }
}
