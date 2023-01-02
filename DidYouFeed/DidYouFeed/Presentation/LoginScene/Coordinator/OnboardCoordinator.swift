//
//  OnboardCoordinator.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/11.
//

import UIKit
import PhotosUI

import Hero

final class OnboardCoordinator: Coordinator {
    
    // MARK: - Properties
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType = .onboard
    
    // MARK: - Initializer
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Functions
    
    func start() {
        let newUserViewModel = NewUserReactor(coordinator: self)
        let newUserViewController = NewUserViewController(reactor: newUserViewModel)
        newUserViewController.titleLabel = newUserViewController.createTitleLabel(
            text: "처음 오셨나봐요.\n당신에 대해 알려주세요."
        )
        self.navigationController.pushViewController(
            newUserViewController,
            animated: true
        )
    }
    
    func showInviteFlow(for userName: String) {
        let inviteReactor = InviteReactor(coordinator: self)
        let inviteViewController = InviteViewController(reactor: inviteReactor)
        inviteViewController.titleLabel = inviteViewController.createTitleLabel(
            text: "반가워요 \(userName)님.\n이제 함께 할 사람들을 찾아봐요."
        )
        self.navigationController.pushViewController(
            inviteViewController,
            animated: true
        )
    }
    
    func showNewFamilyFlow() {
        let newFamilyReactor = NewFamilyReactor(coordinator: self)
        let newFamilyViewController = NewFamilyViewController(reactor: newFamilyReactor)
        newFamilyViewController.titleLabel = newFamilyViewController.createTitleLabel(
            text: "작은 아기 귀염둥이가 기다려요.\n당신만의 패밀리를 만들어주세요."
        )
        self.navigationController.pushViewController(
            newFamilyViewController,
            animated: true
        )
    }
    
    func showNewPetFlow() {
        let newPetCoordinator = NewPetCoordinator(self.navigationController)
        self.childCoordinators.append(newPetCoordinator)
        newPetCoordinator.finishDelegate = self
        newPetCoordinator.start()
    }
	
	func finish() {
		self.navigationController.popToRootViewController(animated: true)
	}
}

extension OnboardCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter {
            $0.type != childCoordinator.type
        }
        childCoordinator.navigationController.popViewController(animated: true)
    }
}
