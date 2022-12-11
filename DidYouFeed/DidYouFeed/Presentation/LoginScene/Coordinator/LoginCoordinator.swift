//
//  LoginCoordinator.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/11.
//

import UIKit

final class LoginCoordinator: Coordinator {
    
    // MARK: - Properties
    
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    // MARK: - Initializer
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Functions
    
    func start() {
        let loginViewModel = LoginReactor(coordinator: self)
        let loginViewController = LoginViewController(reactor: loginViewModel)
        self.navigationController.pushViewController(
            loginViewController,
            animated: true
        )
    }
    
}
