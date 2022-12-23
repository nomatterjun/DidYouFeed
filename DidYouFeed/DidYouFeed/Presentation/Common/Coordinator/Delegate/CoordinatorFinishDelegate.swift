//
//  CoordinatorFinishDelegate.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/23.
//

import Foundation

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}
