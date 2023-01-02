//
//  AppCoordinator.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/05.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType = .app
    
    // MARK: - Initializer
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Functions
    
    func start() {
		if AppData.isLoggedIn == true {
            self.showHomeFlow()
        } else {
            // - TODO: Login 구현 후에 showLoginFlow로 교체
            self.showOnboardFlow()
        }
    }
    
    func showHomeFlow() {
        let homeCoordinator = HomeCoordinator(self.navigationController)
        self.childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
    
    func showOnboardFlow() {
        let onboardCoordinator = OnboardCoordinator(self.navigationController)
        self.childCoordinators.append(onboardCoordinator)
        onboardCoordinator.start()
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
	func coordinatorDidFinish(childCoordinator: Coordinator) {
		self.childCoordinators.removeAll()
		self.navigationController.viewControllers.removeAll()
		
		switch childCoordinator.type {
		case .home:
			self.showOnboardFlow()
		case .onboard:
			self.showHomeFlow()
		default:
			break
		}
	}
}
