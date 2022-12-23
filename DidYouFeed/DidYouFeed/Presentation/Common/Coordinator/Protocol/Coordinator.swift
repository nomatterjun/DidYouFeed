//
//  Coordinator.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/05.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorType { get }
    
    init(_ navigationController: UINavigationController)
    
    func start()
}
