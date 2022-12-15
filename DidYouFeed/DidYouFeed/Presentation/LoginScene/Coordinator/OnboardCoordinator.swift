//
//  OnboardCoordinator.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/11.
//

import UIKit

import Hero

final class OnboardCoordinator: Coordinator {
    
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
        loginViewController.titleLabel = loginViewController.createTitleLabel(
            text: "처음 오셨나봐요.\n당신에 대해 알려주세요."
        )
        self.navigationController.pushViewController(
            loginViewController,
            animated: true
        )
    }
    
    func showJoinFlow(for userName: String) {
        let joinReactor = JoinReactor(coordinator: self)
        let joinViewController = JoinViewController(reactor: joinReactor)
        joinViewController.titleLabel = joinViewController.createTitleLabel(
            text: "반가워요 \(userName)님.\n이제 함께 할 사람들을 찾아봐요."
        )
        self.navigationController.pushViewController(
            joinViewController,
            animated: true
        )
    }
    
    func showNewFamilyFlow() {
        print("New Family")
    }
}
