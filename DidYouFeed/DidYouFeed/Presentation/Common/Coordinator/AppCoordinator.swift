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
            self.showLoginFlow()
        }
    }
    
    func showHomeFlow() {
        
    }
    
    func showLoginFlow() {
        
    }
    
    func finish() {
        //
    }
}
