//
//  ModalViewCoordinator.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/06.
//

import UIKit

final class ModalViewCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var modalViewController: ModalViewController
    
    // MARK: - Initializer
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.modalViewController = ModalViewController()
    }
    
    // MARK: - Functions
    
    func start() {
        self.modalViewController.reactor = ModalViewModel(
            coordinator: self
        )
        self.modalViewController.modalPresentationStyle = .overFullScreen
        self.navigationController.present(
            self.modalViewController,
            animated: true
        )
    }
}
