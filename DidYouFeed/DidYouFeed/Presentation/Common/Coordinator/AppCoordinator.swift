//
//  AppCoordinator.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/05.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    // MARK: - Initializer
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Functions
    
    func start() {
        if UserDefaults.standard.bool(forKey: UserDefaultsKey.isLoggedIn) {
            self.showHomeFlow()
        } else {
            // - TODO: Login 구현 후에 showLoginFlow로 교체
            self.showLoginFlow()
        }
    }
    
    func showHomeFlow() {
        let homeCoordinator = HomeCoordinator(self.navigationController)
        homeCoordinator.parentCoordinator = self
        self.childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
    
    func showLoginFlow() {
        let loginCoordinator = LoginCoordinator(self.navigationController)
        loginCoordinator.navigationController.isNavigationBarHidden = true
        loginCoordinator.parentCoordinator = self
        self.childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
    
    func childCoordinatorDidFinish(_ child: Coordinator) {
        self.childCoordinators.enumerated().forEach { idx, coordinator in
            if coordinator === child {
                childCoordinators.remove(at: idx)
            }
        }
    }
}
